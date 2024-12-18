output "snap_name" {
  value = [
    for sname in azurerm_snapshot.snapshots : sname.name
  ]
}