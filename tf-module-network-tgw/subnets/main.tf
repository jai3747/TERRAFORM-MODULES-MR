resource "aws_subnet" "main" {
  count             = length(var.cidr_block)
  availability_zone = var.availability_zones[count.index]
  cidr_block        = var.cidr_block[count.index]
  vpc_id            = var.vpc_id
  tags              = merge({ Name = "${local.tag_prefix}-subnet" }, var.tags)
}

resource "aws_route_table" "main" {
  count  = length(var.cidr_block)
  vpc_id = var.vpc_id
  tags   = merge({ Name = "${local.tag_prefix}-route-table" }, var.tags)
}

resource "aws_nat_gateway" "nat_gw" {
  count             = var.name == "nat" ? length(aws_subnet.main.*.id) : 0
  connectivity_type = "private"
  subnet_id         = element(aws_subnet.main.*.id, count.index)
  tags              = merge({ Name = "${local.tag_prefix}-ngw" }, var.tags)
}

resource "aws_route_table_association" "association" {
  count          = length(aws_subnet.main.*.id)
  subnet_id      = element(aws_subnet.main.*.id, count.index)
  route_table_id = element(aws_route_table.main.*.id, count.index)
}
