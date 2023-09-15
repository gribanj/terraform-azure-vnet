data "azurerm_virtual_network" "existing_vnet" {
  count               = var.create ? 0 : 1
  name                = var.name
  resource_group_name = var.resource_group_name
}
