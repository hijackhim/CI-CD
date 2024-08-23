variable "project" {
  description = "Project configuration"
  type = object({
    project_id    = string
    project_name  = string
    org_id        = string
    region        = string
    zone          = string
    credentials_file = string
  })
  default = {
    project_id    = "pure-girder-429610-v6"
    project_name  = "Your Project Name"
    org_id        = "your-org-id"
    region        = "us-central1"
    zone          = "us-central1-f"
    credentials_file = "/home/kumar_himanshu_singh28/terraform-replica/key.json"
  }
}

variable "sql_instances" {
  description = "Map of SQL instances with their configurations."
  type = map(object({
    instance_name     = string
    database_version  = string
    database_name     = string
    sql_user_name     = string
    sql_user_password = string
    backup_start_time = string
    disk_autoresize   = bool
    disk_size         = number
    disk_type         = string
  }))
  default = {
    leader_board = {
      instance_name     = "leader-board-1"
      database_version  = "MYSQL_5_7"
      database_name     = "leader_board_db"
      sql_user_name     = "root"
      sql_user_password = "your_leader_board_password"
      backup_start_time = "06:00"
      disk_autoresize   = false
      disk_size         = 10
      disk_type         = "PD_SSD"
    }
    qa_databases = {
      instance_name     = "qa-databases-1"
      database_version  = "MYSQL_8_0_26"
      database_name     = "qa_db"
      sql_user_name     = "root"
      sql_user_password = "your_qa_password"
      backup_start_time = "16:00"
      disk_autoresize   = true
      disk_size         = 10
      disk_type         = "PD_SSD"
    }
  }
}

variable "network" {
  description = "Network configuration"
  type = object({
    private_network            = string
    vpc_connector_region       = string
    vpc_connector_network      = string
    vpc_connector_ip_cidr_range = string
    vpc_connector_min_throughput = number
    vpc_connector_max_throughput = number
  })
  default = {
    private_network            = "projects/linear-aviary-433112-m5/global/networks/default"
    vpc_connector_region       = "us-central1"
    vpc_connector_network      = "default"
    vpc_connector_ip_cidr_range = "10.8.0.0/28"
    vpc_connector_min_throughput = 200
    vpc_connector_max_throughput = 300
  }
}

variable "secret_manager" {
  description = "Secret Manager configuration"
  type = object({
    db_password = string
    service_account_email = string
  })
  default = {
    db_password = "your_database_password"
    service_account_email = "secretmanager@linear-aviary-433112-m5.iam.gserviceaccount.com"
  }
}

#variable "firebase_databases" {
#  description = "Map of Firebase databases to create. The key is the suffix of the database, and the value is any metadata if needed."
#  type        = map(any)
#  default     = {
#    "anything12" = {}  # Define the database name here
#  }
#}