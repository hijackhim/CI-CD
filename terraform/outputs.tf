
output "instance_names" {
  description = "The names of all SQL instances."
  value       = { for k, v in google_sql_database_instance.sql_instances : k => v.name }
}

output "instance_ips" {
  description = "The IP addresses of all SQL instances."
  value       = { for k, v in google_sql_database_instance.sql_instances : k => v.first_ip_address }
}

output "database_names" {
  description = "The names of all databases."
  value       = { for k, v in google_sql_database.sql_databases : k => v.name }
}

output "user_names" {
  description = "The names of all SQL users."
  value       = { for k, v in google_sql_user.sql_users : k => v.name }
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
  value = "https://${var.project.project_id}.appspot.com"
}