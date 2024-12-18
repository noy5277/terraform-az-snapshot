variable "snapshot_resource_group_name" {
  type        = string
  description = "Name of Resource group where the new snapshot resides"
}

variable "tags" {
  description = "A mapping of tags to assign to the Virtual Machine."
  type        = map(any)
}

variable "managed_disk_names" {
  type = map(object({
    disk_name = string
    disk_rg   = string
  }))
}

variable "snapcomment" {
  description = "Snapshot comment (postfix)"
}