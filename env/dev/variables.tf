variable "resource_group_name" {
  type        = string
  description = "Name of the resource group"
}

variable "location" {
  type        = string
  description = "Azure location for all resources"
  default     = "Poland Central"
}

variable "app_service_plan_name" {
  type        = string
  description = "Name for the App Service Plan"
}

variable "frontend_web_app_name" {
  type        = string
  description = "Name for the frontend Windows Web App"
}

variable "backend_web_app_name" {
  type        = string
  description = "Name for the backend Windows Web App"
}

variable "sql_server_name" {
  type        = string
  description = "Name for the SQL Server"
}

variable "sql_database_name" {
  type        = string
  description = "Name for the SQL Database"
}

variable "sql_admin_username" {
  type        = string
  description = "SQL Server admin username"
}

variable "sql_admin_password" {
  type        = string
  description = "SQL Server admin password"
  sensitive   = true
}
