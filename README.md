# Terraform Virtual Network Module

This module handles the creation and data fetching of Azure Virtual Networks based on the specified conditions.
The module follows the principles of "create if not exist". The resource is only created if it doesn't exist. If it exists, it fetches the data of the existing resource.

## Module Declaration / Usage

```hcl
module "vnet" {
  source              = "gribanj/vnet/azure"
  create              = true
  version = "v0.1.0"
  name                = "vnet-xxxxxx-prod"
  resource_group_name = "rg-xxxxxx-prod"
  location            = "westus3"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.1", "10.0.0.2"]
}
```

`create` variable is a flag to determine whether the resource should be created.
If create is true, the resource is created.
If create is false, the module will try to fetch the data of an existing resource with the same name.

## Ternary Operator

This module makes use of the ternary operation, which is a simple form of if-else conditional logic. It's structured as follows:

`condition ? true_val : false_val`

- `condition`: This is a statement that evaluates to either true or false.
- `true_val`: If the condition is true, this value will be used.
- `false_val`: If the condition is false, this value will be used.
  or instance, in the azurerm_virtual_network resource in this module, we use a ternary operation in the `count` parameter:

```hcl
count    = var.create ? 1 : 0

Here, var.create is the condition.
If var.create is true, the count will be 1, meaning one virtual network will be created.
If var.create is false, the count will be 0, meaning no virtual network will be created.
```

## Resources

This module manages the following resources:

- `azurerm_virtual_network:` Manages a virtual network.
- `data.azurerm_virtual_network:` Fetches the data of an existing virtual network.

## Input Variables

- `create`: A boolean flag to create the virtual network or fetch the data of an existing one.
- `name:` The name of the virtual network.
- `resource_group_name:` The name of the resource group in which the virtual network is located.
- `location:` The location of the virtual network.
- `address_space:` A list of address spaces for the virtual network.
- `dns_servers:` A list of DNS servers for the virtual network.
- `tags:` A map of tags to add to the virtual network.

```hcl
provider "azurerm" {
  features {}
}

/*
  Declaring custom tags variables for the resource:
  - we can do it in the module as well and pass it as a variable (locals or regular) to the module
*/
variable "tags" {
  type        = map(string)
  description = "A map of tags to add to the resource"
  default = {
    "createdby" = "griban"
    "workload"  = "v3"
  }
}

locals {
  env = "nonprod"
}

module "vnet" {
  source              = "gribanj/vnet/azure"
  create              = true
  name                = "vnet-xxxxxx-prod"
  resource_group_name = "rg-xxxxxx-prod"
  location            = "westus3"
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.1", "10.0.0.2"]

  # Adding custom tags to the resource

  tags = merge(
    var.tags,
    {
      "env"   = local.env,
      "owner" = "devops"
    },
  )
}
```

## For a specific environment use case

`e.g.`

```hcl
terraform init -backend-config="./prod.tfbackend"
terraform plan -var-file="./terraform.tfvars"
```

## Providers

| Name                                                         | Version |
| ------------------------------------------------------------ | ------- |
| <a name="provider_azurerm"></a> [azurerm](#provider_azurerm) | n/a     |

## Modules

No modules.

## Resources

| Name                                                                                                                                        | Type        |
| ------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network)             | resource    |
| [azurerm_virtual_network.existing_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |

## Inputs

| Name                                                                                       | Description                                                                                      | Type           | Default                                                                             | Required |
| ------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------ | -------------- | ----------------------------------------------------------------------------------- | :------: |
| <a name="input_address_space"></a> [address_space](#input_address_space)                   | The address space that is used the by the virtual network. You should input it in CIDR notation. | `list(string)` | <pre>[<br> "10.0.0.0/16"<br>]</pre>                                                 |    no    |
| <a name="input_create"></a> [create](#input_create)                                        | Boolean flag to control whether a new resource should be created                                 | `bool`         | `false`                                                                             |    no    |
| <a name="input_dns_servers"></a> [dns_servers](#input_dns_servers)                         | List of IP addresses of DNS servers for the virtual network.                                     | `list(string)` | <pre>[<br> "1.1.1.1",<br> "8.8.8.8"<br>]</pre>                                      |    no    |
| <a name="input_location"></a> [location](#input_location)                                  | The location (Azure region) where the resource group and virtual network will be created.        | `string`       | `"westus3"`                                                                         |    no    |
| <a name="input_name"></a> [name](#input_name)                                              | The name of the virtual network.                                                                 | `string`       | n/a                                                                                 |   yes    |
| <a name="input_resource_group_name"></a> [resource_group_name](#input_resource_group_name) | The name of the resource group where the virtual network will be created.                        | `string`       | n/a                                                                                 |   yes    |
| <a name="input_tags"></a> [tags](#input_tags)                                              | A map of tags to add to the resource                                                             | `map(string)`  | <pre>{<br> "env": "prod",<br> "owner": "devops",<br> "terraform": "true"<br>}</pre> |    no    |

## Outputs

| Name                                                                 | Description                                                  |
| -------------------------------------------------------------------- | ------------------------------------------------------------ |
| <a name="output_vnet_output"></a> [vnet_output](#output_vnet_output) | The entire resource object, either existing or newly created |
