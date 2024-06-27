terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.106.1"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "frontend_rg" {
  name     = "resume_frontend"
  location = "eastus"
}

resource "azurerm_storage_account" "staticsite_sa" {
  name                = "staticstrgacct"
  resource_group_name = azurerm_resource_group.frontend_rg.name
  location            = azurerm_resource_group.frontend_rg.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  enable_https_traffic_only        = true
  cross_tenant_replication_enabled = false

  static_website {
    index_document = "index.html"
  }
}

resource "azurerm_storage_blob" "index_blob" {
  name                   = "index.html"
  storage_account_name   = azurerm_storage_account.staticsite_sa.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "text/html"
  source                 = "../src/index.html"
  content_md5            = filemd5("../src/index.html")
}

resource "azurerm_storage_blob" "js_blob" {
  name                   = "js/visits.js"
  storage_account_name   = azurerm_storage_account.staticsite_sa.name
  storage_container_name = "$web"
  type                   = "Block"
  content_type           = "application/javascript"
  source                 = "../src/js/visits.js"
}

resource "azurerm_storage_blob" "img_blobs" {
  for_each               = fileset("../src/img", "**/*")
  name                   = "img/${each.value}"
  storage_account_name   = azurerm_storage_account.staticsite_sa.name
  storage_container_name = "$web"
  type                   = "Block"
  source                 = "../src/img/${each.value}"
  content_type           = "image/${split(".", each.value)[1]}" # assume extensions are like .png, .jpg, etc.
}
