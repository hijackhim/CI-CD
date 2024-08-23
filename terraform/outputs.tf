output "instance_ips" {
  description = "The IP addresses of the SQL instances."
  value       = [
    google_sql_database_instance.leader_board.first_ip_address,
    google_sql_database_instance.qa_databases.first_ip_address
  ]
}

output "database_names" {
  description = "The names of the databases."
  value       = [
    google_sql_database.leader_board_db.name,
    google_sql_database.qa_databases_db.name
  ]
}

output "user_names" {
  description = "The names of the SQL users."
  value       = [
    google_sql_user.leader_board_user.name,
    google_sql_user.qa_databases_user.name
  ]
}

output "vpc_connector_name" {
  description = "The name of the Serverless VPC Connector."
  value       = google_vpc_access_connector.vpc_connector.name
}

output "secret_name" {
  description = "The name of the Secret Manager secret."
  value       = google_secret_manager_secret.db_password.name
}

output "app_engine_url" {
  description = "The App Engine URL."
  value       = "https://${var.project_id}.appspot.com"
}


