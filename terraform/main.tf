provider "google" {
  project     = var.project_id
  region      = var.region
  credentials = file(var.credentials_file)
}

# Cloud SQL Instances
# Leader Board SQL Instance
resource "google_sql_database_instance" "leader_board" {
  name               = var.leader_board_instance.instance_name
  database_version   = var.leader_board_instance.database_version
  region             = var.region
  deletion_protection = false

  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
      start_time                     = var.leader_board_instance.backup_start_time
      transaction_log_retention_days = 7
    }

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }

    disk_autoresize = var.leader_board_instance.disk_autoresize
    disk_size       = var.leader_board_instance.disk_size
    disk_type       = var.leader_board_instance.disk_type
    edition         = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network.private_network
    }

    location_preference {
      zone = var.zone
    }

    pricing_plan = "PER_USE"
    tier         = "db-f1-micro"
  }
}

resource "google_sql_database" "leader_board_db" {
  name     = var.leader_board_instance.database_name
  instance = google_sql_database_instance.leader_board.name
}

resource "google_sql_user" "leader_board_user" {
  name     = var.leader_board_instance.sql_user_name
  instance = google_sql_database_instance.leader_board.name
  password = var.leader_board_instance.sql_user_password
}

# QA Databases SQL Instance
resource "google_sql_database_instance" "qa_databases" {
  name               = var.qa_databases_instance.instance_name
  database_version   = var.qa_databases_instance.database_version
  region             = var.region
  deletion_protection = false

  settings {
    activation_policy = "ALWAYS"
    availability_type = "ZONAL"

    backup_configuration {
      backup_retention_settings {
        retained_backups = 7
        retention_unit   = "COUNT"
      }
      start_time                     = var.qa_databases_instance.backup_start_time
      transaction_log_retention_days = 7
    }

    database_flags {
      name  = "character_set_server"
      value = "utf8mb4"
    }

    disk_autoresize = var.qa_databases_instance.disk_autoresize
    disk_size       = var.qa_databases_instance.disk_size
    disk_type       = var.qa_databases_instance.disk_type
    edition         = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = true
      private_network = var.network.private_network
    }

    location_preference {
      zone = var.zone
    }

    pricing_plan = "PER_USE"
    tier         = "db-f1-micro"
  }
}

resource "google_sql_database" "qa_databases_db" {
  name     = var.qa_databases_instance.database_name
  instance = google_sql_database_instance.qa_databases.name
}

resource "google_sql_user" "qa_databases_user" {
  name     = var.qa_databases_instance.sql_user_name
  instance = google_sql_database_instance.qa_databases.name
  password = var.qa_databases_instance.sql_user_password
}

# Serverless VPC Connector
resource "google_vpc_access_connector" "vpc_connector" {
  name           = "my-serverless-connector"
  region         = var.vpc_connector_region
  network        = var.vpc_connector_network
  ip_cidr_range  = var.vpc_connector_ip_cidr_range
  min_throughput = var.vpc_connector_min_throughput
  max_throughput = var.vpc_connector_max_throughput
}

# Secret Manager Secret
resource "google_secret_manager_secret" "db_password" {
  secret_id = "db-password"
  project   = var.project_id

  replication {
    auto {}
  }
}

resource "google_secret_manager_secret_version" "db_password_version" {
  secret      = google_secret_manager_secret.db_password.id
  secret_data = var.db_password
}

# IAM Binding for Secret Access
resource "google_secret_manager_secret_iam_binding" "secret_access" {
  secret_id = google_secret_manager_secret.db_password.id
  role      = "roles/secretmanager.secretAccessor"

  members = [
    "serviceAccount:${var.service_account_email}"
  ]
}

# Create the App Engine application
#resource "google_app_engine_application" "app" {
#  project     = var.project.project_id
#  location_id = var.project.region
#}