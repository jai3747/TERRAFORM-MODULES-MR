resource "aws_vpc" "main" {
  cidr_block           = var.primary_cidr_block
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags                 = merge({ Name = "${local.tag_prefix}-vpc" }, var.tags)
}

resource "aws_vpc_ipv4_cidr_block_association" "main" {
  count      = var.secondary_cidr_block != null ? 1 : 0
  vpc_id     = aws_vpc.main.id
  cidr_block = var.secondary_cidr_block
}

resource "aws_cloudwatch_log_group" "this" {
  count = var.enable_flow_logs ? 1 : 0
  name  = "${var.env}-${var.name}-flowlog"
  tags  = merge(var.tags, var.cw_flow_log_tags)
}

resource "aws_flow_log" "this" {
  count           = var.enable_flow_logs ? 1 : 0
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.this.0.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags            = merge(var.tags, var.cw_flow_log_tags)
}

module "subnets" {
  source = "./subnets"
  depends_on = [
    aws_vpc.main,
    aws_vpc_ipv4_cidr_block_association.main
  ]

  vpc_id = aws_vpc.main.id
  env    = var.env
  tags   = var.tags

  for_each           = var.subnets
  name               = each.value.name
  cidr_block         = each.value.cidr_block
  availability_zones = var.availability_zones
  nat_gw             = each.value.nat_gw

}

resource "aws_security_group" "default_sg_for_vpc_endpoint" {
  name        = "sg_for_vpc_endpoint"
  description = "Security Group VPC endpoint"
  vpc_id      = aws_vpc.main.id
  tags        = merge({ Name = "${local.tag_prefix}-endpoint-sg" }, var.tags)

  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.additional_cidr_block == null ? [aws_vpc.main.cidr_block, var.secondary_cidr_block] : flatten([aws_vpc.main.cidr_block, var.secondary_cidr_block, var.additional_cidr_block])
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_vpc_endpoint" "interface-endpoint" {
  count               = length(var.in_endpoints)
  vpc_endpoint_type   = "Interface"
  service_name        = lookup(element(var.in_endpoints, count.index), "service", null)
  vpc_id              = aws_vpc.main.id
  security_group_ids  = [aws_security_group.default_sg_for_vpc_endpoint.id]
  subnet_ids          = lookup(lookup(module.subnets, "endpoint", null), "subnet_ids", null)
  private_dns_enabled = true
  tags                = merge({ Name = "${var.env}-${var.name}-interface-ep-${count.index + 1}" }, var.tags)
  depends_on          = [aws_vpc_endpoint.gateway-endpoint]
}

resource "aws_vpc_endpoint" "gateway-endpoint" {
  count             = length(var.gw_endpoints)
  vpc_endpoint_type = "Gateway"
  service_name      = lookup(element(var.gw_endpoints, count.index), "service", null)
  vpc_id            = aws_vpc.main.id
  route_table_ids   = local.route_table_ids
  tags              = merge({ Name = "${var.env}-${var.name}-gateway-endpoint" }, var.tags)
}

resource "aws_ec2_transit_gateway_vpc_attachment" "tgw_attachment" {
  depends_on = [module.subnets]

  subnet_ids                                      = lookup(lookup(module.subnets, "endpoint", null), "subnet_ids", null)
  transit_gateway_id                              = var.transit_gateway_id
  transit_gateway_default_route_table_association = true
  transit_gateway_default_route_table_propagation = true
  vpc_id                                          = aws_vpc.main.id
  tags                                            = merge({ Name = "${var.env}-${var.name}-tgw" }, var.tags)
}


resource "aws_route" "route" {
  count                  = length(local.nat_subnet_present) > 0 && length(local.subnets_to_ngw_list) > 0 ? length(local.route_table_ids_tgw_list) : length(local.route_table_ids)
  route_table_id         = length(local.nat_subnet_present) > 0 && length(local.subnets_to_ngw_list) > 0 ? element(local.route_table_ids_tgw_list, count.index) : element(local.route_table_ids, count.index)
  destination_cidr_block = var.tgw_destination_cidr_block
  transit_gateway_id     = var.transit_gateway_id
}

resource "aws_route" "route-ngw" {
  count                  = length(local.nat_subnet_present) > 0 && length(local.subnets_to_ngw_list) > 0 ? length(local.route_table_ids_ngw_list) : 0
  route_table_id         = element(local.route_table_ids_ngw_list, count.index)
  destination_cidr_block = var.nat_gw_destination_cidr_block
  nat_gateway_id         = element(local.nat_gw_ids, (count.index % length(local.nat_gw_ids)))
}

resource "aws_route" "expected-inbound-traffic" {
  count                  = length(local.nat_subnet_present) > 0 && length(local.subnets_to_ngw_list) > 0 ? (length(local.route_table_ids_ngw_list) * length(var.expected_inbound_cidr_block)) : 0
  route_table_id         = local.route_table_ids_ngw_list[floor(count.index / length(var.expected_inbound_cidr_block))]
  destination_cidr_block = var.expected_inbound_cidr_block[count.index % length(var.expected_inbound_cidr_block)]
  transit_gateway_id     = var.transit_gateway_id
}
