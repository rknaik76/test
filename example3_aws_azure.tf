/*
terraform {
    required_providers {
      aws = {
        source = "hashicorp/aws" 
      }
      azurerm = {
        source = "hashicorp/azurerm" 
      }
    }
  
}

provider "aws" {
    region = "us-east-2"
}

provider "azurerm" {
  features {}    
}

#################
# AWS SERVER
resource "aws_instance" "myserver001" {
  ami = "ami-0233c2d874b811deb"
  instance_type = "t2.nano"
 
  tags = {
    "Name" = "myserver001"
  }

  key_name = "rknaik76"
}

output "ip_address" {
  value = aws_instance.myserver001.public_ip
}
##################
#AZURE SERVER
resource "azurerm_resource_group" "terraformrg" {
  name     = "terraformrg"
  location = "West Europe"
}

resource "azurerm_virtual_network" "terraformvnet" {
  name                = "terraformvnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.terraformrg.location
  resource_group_name = azurerm_resource_group.terraformrg.name
}

resource "azurerm_subnet" "terraformsubnet" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.terraformrg.name
  virtual_network_name = azurerm_virtual_network.terraformvnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "server001nic" {
  name                = "server001nic"
  location            = azurerm_resource_group.terraformrg.location
  resource_group_name = azurerm_resource_group.terraformrg.name
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terraformsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.server001pubip.id
  }
}

resource "azurerm_public_ip" "server001pubip" {
  name = "server001pubip"
  resource_group_name = azurerm_resource_group.terraformrg.name
  location = azurerm_resource_group.terraformrg.location
  allocation_method = "Dynamic" 
}

output "server001pubip" {
  value = "The public IP address of srever is ${azurerm_public_ip.server001pubip.ip_address}"
}

resource "azurerm_linux_virtual_machine" "server001" {
  name                = "server001"
  resource_group_name = azurerm_resource_group.terraformrg.name
  location            = azurerm_resource_group.terraformrg.location
  size                = "Standard_B1ms"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.server001nic.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file(".ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
}

*/