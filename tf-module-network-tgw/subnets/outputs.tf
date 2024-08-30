output "attributes" {
  description = "All subnet Attributes"
  value       = aws_subnet.main
}

output "subnet_ids" {
  description = "Private subnets"
  value       = aws_subnet.main.*.id
}

output "route_table_ids" {
  description = "Route table details"
  value       = aws_route_table.main.*.id
}

output "nat_gateway_ids" {
  value = aws_nat_gateway.nat_gw.*.id
}

output "natgw_routetable_ids" {
  value = var.nat_gw ? aws_route_table.main.*.id : []
}

output "az_subnet_map" {
  value = { for index, value in aws_subnet.main : value.availability_zone => value.id }
}