variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" { default = "Standard_D2lds_v6" }
variable "network_interface_id" {}
variable "identity_id" {}
variable "os_sku" { default = "24.04-LTS" }
variable "os_version" { default = "latest" }
variable "container_image" {}



