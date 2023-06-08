resource "azurerm_virtual_network" "example" {
  # for_each = var.tata

#   for_each = {
#     for v in local.abc : "${g}.${i}" => v
#   }

# for_each = { for ab in local.abc : ab.a => ab}

# for_each = { for o in local.chint2 : value.vnetname =>o}

# for_each = [for b in local.chint3 : b]

# for_each  = [for abc,def in var.tata: def]

for_each = local.chint3

  name                = each.value.vnetname
  location            = "north europe"
  resource_group_name = "abc-rg"
  address_space       = ["10.0.0.0/16"]
  #   dns_servers         = ["10.0.0.4", "10.0.0.5"]
}
variable "tata" {
  type        = map(any)
  description = "(optional) describe your variable"
  default = {
    "asia" = {
      "dmz01" = {
        vnetname = "a1vnet"
      }
      "nondmz01" = {
        vnetname = "a2vnet"
      }
      } }
}

output "out_put_10" {
  value = flatten ([for key, value in var.tata : { for boy, toy in value : boy => toy} ])
}
output "out_put" {
  value = flatten ([for key, value in var.tata : [ for boy, toy in value :{  vnetname = toy.vnetname} ]])
}

output "out_put_4" {
  value = flatten ([for key, value in var.tata : { for boy, toy in value : boy => toy.vnetname} ])
}

output "out_put_7" {
  value = flatten ([for key, value in var.tata : { for boy, toy in value : boy => toy} ])
}

locals {
  chint3 = flatten ([for key, value in var.tata : { for boy, toy in value : boy => toy} ]) 
}

output "output_8" {
  value = [for b in local.chint3 : b]
}

output "output_9" {
  value = local.chint3
}



# output "out_put_2" {
#   value = flatten ([for key, value in var.tata : value.vnetname])
# }

output "out_put_3" {
  value = [for abc,def in var.tata: def]
}

output "output_5" {
  value =  [for a, b in local.chint2 : b]
  
}

output "output_6" {
  value =  {for a, b in local.chint2 : a=> b}
  
}


locals {
  chint = flatten ([for key, value in var.tata : [ for boy, toy in value :{  vnetname = toy.vnetname} ]])
}

locals {
  chint2 = flatten ([for key, value in var.tata : { for boy, toy in value : boy => toy.vnetname} ])
}


        