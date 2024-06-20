output "static_site_url" {
    value = azurerm_storage_account.staticsite_sa.primary_web_endpoint
    description = "Static website URL"
}
