output "frontend_url" {
  value = "http://${azurerm_linux_virtual_machine.virtual-machine-frontend.public_ip_address}:8080"
}