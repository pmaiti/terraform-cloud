resource "azurerm_virtual_network" "vnet-mighty" {
  name                = "vnet-${terraform.workspace}-mighty" #var.virtual_network_name
  location            = azurerm_resource_group.rg-mighty.location  
  resource_group_name = azurerm_resource_group.rg-mighty.name
  address_space       = [local.virtual_network_address_space[terraform.workspace]]
  tags = local.common_tags[terraform.workspace]
  depends_on = [
    azurerm_resource_group.rg-mighty
  ]  
} 


resource "azurerm_subnet" "snets-mighty" {    
    count = length(local.subnet_address_prefix[terraform.workspace])
    name                 = "snet-${terraform.workspace}-mighty${count.index}" #var.subnets[count.index].name
    resource_group_name  = azurerm_resource_group.rg-mighty.name
    virtual_network_name = azurerm_virtual_network.vnet-mighty.name
    address_prefixes     = [cidrsubnet(local.virtual_network_address_space[terraform.workspace], 8, count.index)]#[local.subnet_address_prefix[terraform.workspace][count.index]]
    depends_on = [
      azurerm_virtual_network.vnet-mighty
    ]
}

resource "azurerm_network_security_group" "nsg-mighty" {
  name                = "nsg-${terraform.workspace}-mighty"
  location            = azurerm_resource_group.rg-mighty.location  
  resource_group_name = azurerm_resource_group.rg-mighty.name
  tags = local.common_tags[terraform.workspace]
  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

depends_on = [
    azurerm_virtual_network.vnet-mighty
  ]
}

resource "azurerm_subnet_network_security_group_association" "nsgs-link-mighty" {
  subnet_id                 = azurerm_subnet.snets-mighty[0].id
  network_security_group_id = azurerm_network_security_group.nsg-mighty.id

  depends_on = [
    azurerm_subnet.snets-mighty
    , azurerm_network_security_group.nsg-mighty
  ]
}
