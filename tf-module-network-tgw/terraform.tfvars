# terraform.tfvars

# Primary VPC CIDR Block
primary_cidr_block = "10.0.0.0/16"

# Secondary CIDR Block (if any)
secondary_cidr_block = null

# DNS Support
enable_dns_support = true

# DNS Hostnames
enable_dns_hostnames = true

# Environment (e.g., dev, prod)
env = "dev"

# Name of the VPC/Project
name = "my-vpc-project"

# Enable Flow Logs
enable_flow_logs = true

# Availability Zones
availability_zones = ["ap-south-1a", "ap-south-1b"]

# NAT Gateway Destination CIDR Block
nat_gw_destination_cidr_block = "0.0.0.0/0"

# Internet Gateway Destination CIDR Block
igw_destination_cidr_block = "0.0.0.0/0"

# AWS Transit Gateway Destination CIDR Block
tgw_destination_cidr_block = "10.0.0.0/16"  # Replace with your desired CIDR block

# AWS Transit Gateway ID
transit_gateway_id = "tgw-09ee19c8f8c5ff32e"  # Replace with your actual transit gateway ID

# Tags
tags = {
  "Owner"       = "team-devops"\

  "Environment" = "development"
}

# CloudWatch Flow Log Tags
cw_flow_log_tags = {
  "LogType" = "VPC Flow Logs"
}

# Subnets
subnets = {
  "public-1" = {
    name                    = "public-subnet-1"
    cidr_block              = ["10.0.1.0/24"]
    nat_gw                  = false
    map_public_ip_on_launch = true
    igw_gw                  = true
    lb_annotation           = {}
  },
  "private-1" = {
    name                    = "private-subnet-1"
    cidr_block              = ["10.0.2.0/24"]
    nat_gw                  = true
    map_public_ip_on_launch = false
    igw_gw                  = false
    lb_annotation           = {}
  },
  "endpoint" = {
    name                    = "endpoint-subnet"
    cidr_block              = ["10.0.3.0/24"]
    nat_gw                  = false
    map_public_ip_on_launch = false
    igw_gw                  = false
    lb_annotation           = {}
  }
}

# Internal Endpoints
in_endpoints = [
  {
    service = "com.amazonaws.ap-south-1.ec2"
  },
  {
    service = "com.amazonaws.ap-south-1.ssm"
  }
]

# Gateway Endpoints
gw_endpoints = [
  {
    service = "com.amazonaws.ap-south-1.s3"
  },
  {
    service = "com.amazonaws.ap-south-1.dynamodb"
  }
]

# Additional CIDR Block
additional_cidr_block = null

# Expected Inbound CIDR Block
expected_inbound_cidr_block = "192.168.1.0/24"  # Example value; adjust as needed

