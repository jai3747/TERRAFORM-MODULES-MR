output "subnets" {
  description = "All subnet ids"
  value       = module.subnets
}

output "route_table_ids" {
  description = "All route table ids"
  value       = local.route_table_ids
}

output "vpc" {
  description = "VPC attributes"
  value       = aws_vpc.main
}

output "az_subnet_map" {
  description = "AZ subnet ids map"
  value       = { for key, value in module.subnets : key => value.az_subnet_map }
}

output "db_subnet_ids" {
  value = [for i in module.subnets : i.subnet_ids if i == "db"]
}

output "msk_subnet_ids" {
  value = [for i in module.subnets : i.subnet_ids if i == "msk"]
}

output "endpoint_sg_id" {
  value = aws_security_group.default_sg_for_vpc_endpoint.id
}

