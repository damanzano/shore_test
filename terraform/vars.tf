
variable "location" {
  description = "Azure location for resoruces"
  default = "canadacentral"
}

variable "vm_ssh_key" {
  description = "Location of the public ssh to use for VMs configuration"
  default = "~/.ssh/id_rsa.pub"
}

variable "vm_adminuser" {
  description = "Administrator user to configure VMs"
  default = "adminuser"
}

variable "vm_size" {
  description = "Compute size of VMs"
  default = "Standard_D2s_v3"
}

variable "vm_storage_type" {
  description = "Storage type for VMs"
  default = "StandardSSD_LRS"
}
