variable "vm_name" {}
variable "resource_group_name" {}
variable "location" {}
variable "vm_size" { default = "Standard_F2" }
variable "network_interface_id" {}
variable "identity_id" {}
 
variable "os_image" {
  description = "Ubuntu Server image reference"
  default = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "24_04-lts-gen2"  # Gen2 VM required for 24.04 LTS
    version   = "latest"
  }
}
variable "vm_size" {
  description = "Azure VM size"
  default     = "Standard_D2lds_v6"  # Or your preferred size like "Standard_D2s_v3"
}
variable "container_image" {}

