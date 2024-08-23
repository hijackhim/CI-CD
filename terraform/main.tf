provider "google" {
  project     = var.project.project_id
  region      = var.project.region
  credentials = file(var.project.credentials_file)
}

# Cloud SQL Instances
resource "google_sql_database_instance" "sql_instances" {
  for_each           = var.sql_instances
  database_version   = each.value.database_version
  instance_type      = "CLOUD_SQL_INSTANCE"
  name               = each.value.instance_name
  project            = var.project.project_id
  region             = var.project.region
  deletion_protection = false

  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
      start_time                     = each.value.backup_start_time
      transaction_log_retention_days = 7
    }

    connector_enforcement = "NOT_REQUIRED"

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }

    disk_autoresize       = each.value.disk_autoresize
    disk_size             = each.value.disk_size
    disk_type             = each.value.disk_type
    edition               = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network.private_network
    }

    location_preference {
      zone = var.project.zone
    }

    pricing_plan = "PER_USE"
    tier         = "db-f1-micro"
  }
}

resource "google_sql_database" "sql_databases" {
  for_each = var.sql_instances
  name     = each.value.database_name
  instance = google_sql_database_instance.sql_instances[each.key].name
}

resource "google_sql_user" "sql_users" {
  for_each = var.sql_instances
  name     = each.value.sql_user_name
  project  = var.project.project_id
  instance = google_sql_database_instance.sql_instances[each.key].name
  password = each.value.sql_user_password
}

# Serverless VPC Connector
resource "google_vpc_access_connector" "vpc_connector" {
  name           = "my-serverless-connector"
  region         = var.network.vpc_connector_region
  network        = var.network.vpc_connector_network
  ip_cidr_range  = var.network.vpc_connector_ip_cidr_range
  min_throughput = var.network.vpc_connector_min_throughput
  max_throughput = var.network.vpc_connector_max_throughput
}

# Secret Manager Secret
resource "google_secret_manager_secret" "db_password" {
  secret_id = "db-password"
  project   = var.project.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.secret_manager.db_password
}

# IAM Binding for Secret Access
resource "google_secret_manager_secret_iam_binding" "secret_access" {
  secret_id = google_secret_manager_secret.db_password.id
  role      = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:${var.secret_manager.service_account_email}"
  ]
}