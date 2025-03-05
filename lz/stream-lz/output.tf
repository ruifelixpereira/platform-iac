output "stream_vnets" {
  value       = {for vnet in module.stream_vnet: vnet.name => vnet.id}
  description = "The output value of the Vnet ID."
}
