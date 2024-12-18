#Snapshot creation / Murali Thangavel 

terraform {
  required_providers {
    azurerm = {
      version = "~>3.112.0"
    }
  }
}

provider "azurerm" {
  features {}
}

data "azurerm_managed_disk" "disks" {
  for_each            = var.managed_disk_names
  name                = each.value["disk_name"]
  resource_group_name = each.value["disk_rg"]
}

data "azurerm_resource_group" "rg" {
  name = var.snapshot_resource_group_name
}

resource "azurerm_snapshot" "snapshots" {
  for_each            = var.managed_disk_names
  name                = "${each.value["disk_name"]}-SS${var.snapcomment}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = var.snapshot_resource_group_name
  create_option       = "Copy"
  source_uri          = data.azurerm_managed_disk.disks[each.key].id
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      tags
    ]
  }
}