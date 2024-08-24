project_id       = "linear-aviary-433112-m5"
region           = "us-central1"
zone             = "us-central1-f"
credentials_file = "$HOME/key.json"

leader_board_instance = {
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

qa_databases_instance = {
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

network = {
  private_network = "projects/linear-aviary-433112-m5/global/networks/default"
}

vpc_connector_region         = "us-central1"
vpc_connector_network        = "default"
vpc_connector_ip_cidr_range  = "10.8.0.0/28"
vpc_connector_min_throughput = 200
vpc_connector_max_throughput = 300

db_password = "your_database_password"

service_account_email = "secretmanager@linear-aviary-433112-m5.iam.gserviceaccount.com"