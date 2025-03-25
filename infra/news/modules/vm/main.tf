resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "adminuser"
  network_interface_ids = [var.network_interface_id]

  identity {
    type         = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("${path.module}/../../id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = var.os_sku
    version   = var.os_version
  }

  connection {
    host        = self.public_ip_address
    user        = "adminuser"
    type        = "ssh"
    private_key = file("${path.module}/../../id_rsa")
    timeout     = "1m"
    agent       = false
  }

  provisioner "file" {
    source      = "${path.module}/../../provision-docker.sh"
    destination = "/home/adminuser/provision-docker.sh"
  }

  provisioner "file" {
    source      = "${path.module}/../../provision-${var.vm_name}.sh"
    destination = "/home/adminuser/provision-${var.vm_name}.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/adminuser/provision-docker.sh",
      "/home/adminuser/provision-docker.sh"
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/adminuser/provision-${var.vm_name}.sh",
      "/home/adminuser/provision-${var.vm_name}.sh ${var.container_image} ${var.identity_id} ${var.vm_name.azurecr.io}"
    ]
  }
}
