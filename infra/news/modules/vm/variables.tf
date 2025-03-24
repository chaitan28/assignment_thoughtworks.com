variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" { default = "Standard_B1s" }
variable "network_interface_id" {}
variable "identity_id" {}
variable "os_sku" { default = "19_04-gen2" }
variable "os_version" { default = "19.04" }
variable "container_image" {}



