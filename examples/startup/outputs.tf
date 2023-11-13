output "vnet_output" {
  description = "The entire resource object, either existing or newly created"
  value       = module.vnet.vnet_output[0]
}
