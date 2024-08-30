variable "tags" {
  type    = map(string)
  default = {}
}

variable "availability_zones" {
  description = "list of availability zones"
  type        = list(string)
}

variable "nat_gw" {
  description = "Attach nat gateway to subnets or not"
  type        = bool
}

variable "subnet_tags" {
  description = "tags specific to subnet"
  type        = map(string)
  default     = {}

}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "env" {
  description = "Name of the enviornment"
  type        = string
}

variable "cidr_block" {}
variable "name" {}


