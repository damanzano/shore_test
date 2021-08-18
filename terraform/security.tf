# Access to VM1
resource "azurerm_network_security_group" "internal_nsg" {
  name                = "VM1SecurityGroup"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
}

resource "azurerm_network_security_rule" "vm1_ssh" {
  name                        = "allow_internal_access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "*"
  source_address_prefix       = "174.91.158.103/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.app_rg.name
  network_security_group_name = azurerm_network_security_group.internal_nsg.name
}

# Ovewrite default behavior in azure that allow all traffic from virtual networks and loadbalancer
resource "azurerm_network_security_rule" "deny_all_vm1" {
  name                        = "deny_traffic"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.app_rg.name
  network_security_group_name = azurerm_network_security_group.internal_nsg.name
}

resource "azurerm_network_interface" "vm1_ni" {
  name                = "VM1NetInterface"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.app_internal_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "internal_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm1_ni.id
  network_security_group_id = azurerm_network_security_group.internal_nsg.id
}


# Access to VM2 and VM3
resource "azurerm_network_security_group" "web_nsg" {
  name                = "WebVMsSecurityGroup"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
}

resource "azurerm_network_security_rule" "internal_ssh" {
  name                        = "internal_access"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "22"
  destination_port_range      = "*"
  source_address_prefix       = azurerm_linux_virtual_machine.vm1.private_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.app_rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

resource "azurerm_network_security_rule" "external_web" {
  name                        = "external_https"
  priority                    = 101
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "443"
  destination_port_range      = "*"
  source_address_prefix       = "0.0.0.0"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.app_rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

# Ovewrite default behavior in azure that allow all traffic from virtual networks and loadbalancer
resource "azurerm_network_security_rule" "deny_all_web" {
  name                        = "deny_traffic"
  priority                    = 102
  direction                   = "Inbound"
  access                      = "Deny"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.app_rg.name
  network_security_group_name = azurerm_network_security_group.web_nsg.name
}

resource "azurerm_network_interface" "vm2_ni" {
  name                = "VM2NetInterface"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.app_public_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "vm3_ni" {
  name                = "VM3NetInterface"
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name

  ip_configuration {
    name                          = "public"
    subnet_id                     = azurerm_subnet.app_public_snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "vm2_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm2_ni.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}

resource "azurerm_network_interface_security_group_association" "vm3_nsg_association" {
  network_interface_id      = azurerm_network_interface.vm3_ni.id
  network_security_group_id = azurerm_network_security_group.web_nsg.id
}
