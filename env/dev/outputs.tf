output "frontend_web_app_url" {
  value = azurerm_static_web_app.frontend.default_host_name
}

output "backend_web_app_url" {
  value = azurerm_linux_web_app.backend.default_hostname
}

output "sql_server_fqdn" {
  value = azurerm_mssql_server.main.fully_qualified_domain_name
}

output "sql_database_id" {
  value = azurerm_mssql_database.main.id
}
