# Global virtual network
resource "azurerm_virtual_network" "app_vnet" {
    name                = "AppVnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.location
    resource_group_name = azurerm_resource_group.app_rg.name
}

# Private subnet
resource "azurerm_subnet" "app_internal_snet" {
  name                 = "AppInternalSnet"
  resource_group_name  = azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}


# Public subnet
resource "azurerm_subnet" "app_public_snet" {
  name                 = "AppPublicSnet"
  resource_group_name  = azurerm_resource_group.app_rg.name
  virtual_network_name = azurerm_virtual_network.app_vnet.name
  address_prefixes     = ["10.0.3.0/24"]
}

