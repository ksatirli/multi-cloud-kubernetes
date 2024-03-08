# see https://registry.terraform.io/modules/Azure/network/azurerm/5.3.0
module "network" {
  source  = "Azure/network/azurerm"
  version = "5.3.0"

  resource_group_name = azurerm_resource_group.cluster.name

  address_spaces = [
    "10.0.0.0/16",
    "10.2.0.0/16",
  ]

  subnet_prefixes = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24",
  ]

  subnet_names = [
    "subnet1",
    "subnet2",
    "subnet3",
  ]

  subnet_delegation = {
    subnet1 = [
      {
        name = "delegation"
        service_delegation = {
          name = "Microsoft.ContainerInstance/containerGroups"
          actions = [
            "Microsoft.Network/virtualNetworks/subnets/action",
          ]
        }
      }
    ]
  }

  use_for_each = true

  # see https://developer.hashicorp.com/terraform/language/meta-arguments/depends_on
  depends_on = [
    azurerm_resource_group.cluster
  ]
}
