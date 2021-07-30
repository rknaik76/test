# Example of using a variable
# rgname and rgloc are variablized
/* 
terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
    }
    #google = {
    #    source = "hashicorp/google"
    #}
    #aws = {
    #    source = "hashicorp/aws"
    #}
  }
}
 
provider "azurerm" {
  features {
    virtual_machine {
        delete_os_disk_on_deletion = false
    } 
  }
}




/* 
provider "google" {
  
}

provider "aws" {
  
}

variable "rgname" {
  type = string
  default = "testrg"
  description = "Variable to store RG Name"
}

variable "rgloc" {
  type = string
  default = "West Europe"
  description = "Location of RG"
}

resource "azurerm_resource_group" "rg" {
  name = var.rgname
  location = var.rgloc
}

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
