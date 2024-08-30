variable "additional_tags" {
  type    = map(string)
  default = {}
}

variable "env" {
  description = "AWS Environment"
  type        = string
}

variable "name" {
  description = "AWS resources prefix name"
  type        = string
}

variable "primary_cidr_block" {
  description = "AWS VPC primary CIDR block"
  type        = string
}

variable "enable_dns_support" {
  description = "Enable DNS support for VPC"
  type        = bool
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames for VPC"
  type        = bool
}

variable "enable_flow_logs" {
  description = "Enable flow logs or not"
  type        = bool
}


variable "vpc_tags" {
  description = "tags specific to VPC"
  type        = map(string)
  default     = {}
}

variable "secondary_cidr_block" {
  description = "VPC secondary CIDR block"
  type        = string
  default     = null
}

variable "cw_flow_log_tags" {
  description = "AWS CloudWatch group tags"
  type        = map(string)
  default     = {}
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)

}

variable "subnets" {
  description = "AWS VPC subnet config values"
  type = map(object({
    name       = string
    cidr_block = list(string)
    nat_gw     = bool
  }))

}

variable "in_endpoints" {
  description = "VPC interface endpoints"
  type = list(object({
    service = string
  }))
}

variable "gw_endpoints" {
  description = "VPC interface endpoints"
  type = list(object({
    service = string
  }))
}

variable "endpoint_tags" {
  description = "VPC Endpoint tags"
  type        = map(string)
  default     = {}
}

variable "transit_gateway_id" {
  description = "AWS transit gateway id"
  type        = string
}

variable "tgw_tags" {
  description = "AWS transit gateway specific tags"
  type        = map(string)
  default     = {}
}

variable "tgw_destination_cidr_block" {
  description = "AWS transit gateway destination CIDR"
  type        = string
}

variable "nat_gw_destination_cidr_block" {
  description = "NAT Gateway destination CIDR"
  type        = string
}

variable "expected_inbound_cidr_block" {
  description = "Expected inbound CIDR block"
  type        = list(string)
}

variable "additional_cidr_block" {
  description = "On-prem CIDR block"
  type        = list(string)
  default     = null
}
#variable "tgw_attachment_subnets_name" {
#  description = "Subnets logical name to attach TGW"
#  type = string
#
#}

variable "tags" {}


