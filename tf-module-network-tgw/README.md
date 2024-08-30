<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_subnets"></a> [subnets](#module\_subnets) | ./subnets | n/a |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_flow_log.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_role.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.flow_log](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_security_group.default_sg_for_vpc_endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_vpc_endpoint.gateway-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_endpoint.interface-endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_endpoint) | resource |
| [aws_vpc_ipv4_cidr_block_association.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_ipv4_cidr_block_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | Availability zones | `list(string)` | n/a | yes |
| <a name="input_cw_flow_log_tags"></a> [cw\_flow\_log\_tags](#input\_cw\_flow\_log\_tags) | AWS CloudWatch group tags | `map(string)` | `{}` | no |
| <a name="input_enable_dns_hostnames"></a> [enable\_dns\_hostnames](#input\_enable\_dns\_hostnames) | Enable DNS hostnames for VPC | `bool` | n/a | yes |
| <a name="input_enable_dns_support"></a> [enable\_dns\_support](#input\_enable\_dns\_support) | Enable DNS support for VPC | `bool` | n/a | yes |
| <a name="input_enable_flow_logs"></a> [enable\_flow\_logs](#input\_enable\_flow\_logs) | Enable flow logs or not | `bool` | n/a | yes |
| <a name="input_endpoint_tags"></a> [endpoint\_tags](#input\_endpoint\_tags) | VPC Endpoint tags | `map(string)` | `{}` | no |
| <a name="input_env"></a> [env](#input\_env) | AWS Environment | `string` | n/a | yes |
| <a name="input_gw_endpoints"></a> [gw\_endpoints](#input\_gw\_endpoints) | VPC interface endpoints | <pre>list(object({<br>    service = string<br>  }))</pre> | n/a | yes |
| <a name="input_in_endpoints"></a> [in\_endpoints](#input\_in\_endpoints) | VPC interface endpoints | <pre>list(object({<br>    service = string<br>  }))</pre> | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | AWS resources prefix name | `string` | n/a | yes |
| <a name="input_primary_cidr_block"></a> [primary\_cidr\_block](#input\_primary\_cidr\_block) | AWS VPC primary CIDR block | `string` | n/a | yes |
| <a name="input_secondary_cidr_block"></a> [secondary\_cidr\_block](#input\_secondary\_cidr\_block) | VPC secondary CIDR block | `string` | `null` | no |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | AWS VPC subnet config values | <pre>map(object({<br>    name = string<br>    cidr_block = list(string)<br>    nat_gw = bool<br>  }))</pre> | n/a | yes |
| <a name="input_tgw_destination_cidr_block"></a> [tgw\_destination\_cidr\_block](#input\_tgw\_destination\_cidr\_block) | AWS transit gateway destination CIDR | `string` | n/a | yes |
| <a name="input_tgw_tags"></a> [tgw\_tags](#input\_tgw\_tags) | AWS transit gateway specific tags | `map(string)` | `{}` | no |
| <a name="input_transit_gateway_id"></a> [transit\_gateway\_id](#input\_transit\_gateway\_id) | AWS transit gateway id | `string` | n/a | yes |
| <a name="input_vpc_tags"></a> [vpc\_tags](#input\_vpc\_tags) | tags specific to VPC | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_route_table_ids"></a> [route\_table\_ids](#output\_route\_table\_ids) | All route table ids |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | All subnet ids |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | VPC attributes |
<!-- END_TF_DOCS -->