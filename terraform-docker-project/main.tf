provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "devops-test-rg"
  location = "East US"
}
