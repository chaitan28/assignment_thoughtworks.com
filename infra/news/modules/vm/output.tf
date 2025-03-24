output "frontend_url" {
  value = "http://${azurerm_linux_virtual_machine.vm.public_ip_address}:8080"
}
output "newsfeed_url" {
  value = "http://${azurerm_linux_virtual_machine.vm.public_ip_address}:8081"
}
output "quotes_url" {
  value = "http://${azurerm_linux_virtual_machine.vm.public_ip_address}:8082"
}