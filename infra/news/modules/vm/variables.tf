variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" { default = "Standard_B1s" }
variable "network_interface_id" {}
variable "identity_id" {}
variable "os_sku" { default = "22_04-lts-gen2" }
variable "os_version" { default = "latest" }
variable "container_image" {}



