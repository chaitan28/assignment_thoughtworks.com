variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" { default = "Standard_B1s" }
variable "network_interface_id" {}
variable "identity_id" {}
variable "os_sku" { default = "20.04-LTS" }
variable "os_version" { default = " x64 Gen2" }
variable "container_image" {}



