output "internal_ip_address_manager" {
  value = module.swarm[*].internal_ip_address_manager
}

output "external_ip_address_manager" {
  value = module.swarm[*].external_ip_address_manager
}

output "internal_ip_address_worker" {
  value = module.swarm[*].internal_ip_address_worker
}

output "external_ip_address_worker" {
  value = module.swarm[*].external_ip_address_worker
}

