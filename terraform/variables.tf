variable "project_id" {
  description = "GCP Project ID"
  type        = string
  default     = "pure-girder-429610-v6"
}

variable "project_name" {
  description = "GCP Project Name"
  type        = string
  default     = "Your Project Name"
}

variable "org_id" {
  description = "Organization ID"
  type        = string
  default     = "your-org-id"
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "GCP Zone"
  type        = string
  default     = "us-central1-f"
}

variable "credentials_file" {
  description = "Path to the Google Cloud credentials file."
  type        = string
  default     = "/home/kumar_himanshu_singh28/terraform-replica/key.json"
}


variable "leader_board_instance" {
  description = "Configuration for the leader board SQL instance."
  type = object({
    instance_name     = string
    database_version  = string
    database_name     = string
    sql_user_name     = string
    sql_user_password = string
    backup_start_time = string
    disk_autoresize   = bool
    disk_size         = number
    disk_type         = string
  })
  default = {
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
}

variable "qa_databases_instance" {
  description = "Configuration for the QA databases SQL instance."
  type = object({
    instance_name     = string
    database_version  = string
    database_name     = string
    sql_user_name     = string
    sql_user_password = string
    backup_start_time = string
    disk_autoresize   = bool
    disk_size         = number
    disk_type         = string
  })
  default = {
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

variable "network" {
  description = "The network configurations."
  type = object({
    private_network = string
  })
  default = {
    private_network = "projects/linear-aviary-433112-m5/global/networks/default"
  }
}

variable "vpc_connector_region" {
  description = "Region for the VPC connector."
  type        = string
  default     = "us-central1"
}

variable "vpc_connector_network" {
  description = "VPC network for the connector."
  type        = string
  default     = "default"
}

variable "vpc_connector_ip_cidr_range" {
  description = "IP CIDR range for the VPC connector."
  type        = string
  default     = "10.8.0.0/28"
}

variable "vpc_connector_min_throughput" {
  description = "Minimum throughput for the VPC connector."
  type        = number
  default     = 200
}

variable "vpc_connector_max_throughput" {
  description = "Maximum throughput for the VPC connector."
  type        = number
  default     = 300
}

variable "db_password" {
  description = "Secret manager database password."
  type        = string
  default     = "your_database_password"
}

variable "service_account_email" {
  description = "Service account email for secret manager access."
  type        = string
  default     = "secretmanager@linear-aviary-433112-m5.iam.gserviceaccount.com"
}

