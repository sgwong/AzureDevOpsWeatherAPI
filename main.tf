terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "Southeast Asia"
}

resource "azurerm_container_group" "tfcg_test" {
    name = "weatherapi"
    location = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type = "public"
    dns_name_label = "sgwong513"
    os_type = "Linux"

    container {
        name    = "weatherapi"
        image   = "sgwong513/weatherapi"
        cpu     = "1"
        memory  = "1"

        ports {
            port    = 80
            protocol = "TCP"
        }
    }
}
