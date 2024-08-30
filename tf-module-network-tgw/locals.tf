locals {
  ## All Route table IDS
  route_table_ids = flatten([for key, value in module.subnets : value.route_table_ids])
  ## Check if NAT subnet is present in the inputs file
  nat_subnet_present = [for key, value in var.subnets : value.name if value.name == "nat"]
  ## Fetch all subnets except EKS primary [lb, db, msk, ...]
  subnets_to_tgw_list = [for key, value in var.subnets : value.name if value.nat_gw == false]
  ## Fetch only EKS primary subnets [eks-spark-primary, eks-vault-primary]
  subnets_to_ngw_list = [for key, value in var.subnets : value.name if value.nat_gw == true]
  ## Fetch all route tables that needs to be pointed to tgw (all route tables except EKS primary)
  route_table_ids_tgw_list = flatten([for key, value in module.subnets : !contains(local.subnets_to_ngw_list, key) ? value.route_table_ids : []])
  ## Fetch all route tables that needs to be pointed to ngw (only EKS primary)
  route_table_ids_ngw_list = flatten([for key, value in module.subnets : contains(local.subnets_to_ngw_list, key) ? value.route_table_ids : []])

  route_table_ids_except_eks = flatten([for key, value in module.subnets : key != "eks-sparksvc-primary" && key != "eks-vaultcore-primary" ? value.route_table_ids : []])
  route_table_ids_eks_spark  = flatten([for key, value in module.subnets : key == "eks-sparksvc-primary" ? value.route_table_ids : []])
  route_table_ids_eks_vcore  = flatten([for key, value in module.subnets : key == "eks-vaultcore-primary" ? value.route_table_ids : []])
  subnet_ids                 = flatten([for key, value in module.subnets : value.subnet_ids])
  natgw_routetable_ids       = flatten([for key, value in module.subnets : value.natgw_routetable_ids])
  nat_gw_ids                 = length(local.nat_subnet_present) > 0 ? lookup(lookup(module.subnets, "nat", null), "nat_gateway_ids", null) : null

  tag_prefix = "${var.env}-${var.name}"
}