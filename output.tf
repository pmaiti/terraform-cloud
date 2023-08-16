output "resource_group_name" {
    value = azurerm_resource_group.rg-mighty.name
}

output "resource_group" {
    value = azurerm_resource_group.rg-mighty
}

output "location" {
    value = azurerm_virtual_network.vnet-mighty.location
}

output "subnets" {
    value = azurerm_subnet.snets-mighty
}