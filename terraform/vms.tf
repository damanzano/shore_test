# VM1
resource "azurerm_linux_virtual_machine" "vm1" {
  name                = "VM1"
  computer_name       = "VM1"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  size                = var.vm_size
  admin_username      = var.vm_adminuser
  network_interface_ids = [
    azurerm_network_interface.vm1_ni.id,
  ]

  admin_ssh_key {
    username   = var.vm_adminuser
    public_key = file(var.vm_ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_storage_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

# VM2
resource "azurerm_linux_virtual_machine" "vm2" {
  name                = "VM2"
  computer_name       = "VM2"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  size                = var.vm_size
  admin_username      = var.vm_adminuser
  network_interface_ids = [
    azurerm_network_interface.vm2_ni.id,
  ]

  admin_ssh_key {
    username   = var.vm_adminuser
    public_key = file(var.vm_ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_storage_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}

# VM3
resource "azurerm_linux_virtual_machine" "vm3" {
  name                = "VM3"
  computer_name       = "VM3"
  resource_group_name = azurerm_resource_group.app_rg.name
  location            = azurerm_resource_group.app_rg.location
  size                = var.vm_size
  admin_username      = var.vm_adminuser
  network_interface_ids = [
    azurerm_network_interface.vm3_ni.id,
  ]

  admin_ssh_key {
    username   = var.vm_adminuser
    public_key = file(var.vm_ssh_key)
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.vm_storage_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
}
