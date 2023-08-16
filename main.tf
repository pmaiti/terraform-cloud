resource "azurerm_resource_group" "rg-mighty" {
    name     = "rg-${terraform.workspace}-mighty" #var.resource_group_name
    location = local.location
}


