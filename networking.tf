# 1. Creates a vpc for our demo
resource "aws_vpc" "first_vpc" {
  cidr_block = "10.0.0.0/16" # = 65536 IPs from 10.0.0.0 to 10.0.255.255 (note, some IPs are reserved, so actual usable IP count may be less)
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "My First VPC"
    Team = "Acme Squad"
    Environment = "Development"
    Region = var.default-region
  }
}

# 2. Create Internet Gateway for public subnets
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.first_vpc.id
  tags = {
    Name = "Internet Gateway for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Region = var.default-region
  }
}

# 2. Creates public / private subnet under our first vpc
# following the best practices mentioned in https://aws.amazon.com/solutions/implementations/vpc/ and https://aws-quickstart.github.io/quickstart-aws-vpc/
# which we will create 4 AZs, 2 private subnets, 1 public subnet and 1 spare capacity for each AZ
locals {
  az_subnets = flatten([
    for az in var.az_config : [
        for j, subnet in az.subnets : {
          subnet_key = j
          availability_zone = az.az_name
          cidr_block = subnet.cidr_block
          is_private = subnet.is_private
        }
    ]
  ])
}

resource "aws_subnet" "subnets" {
  for_each = { for subnet in local.az_subnets : "${subnet.availability_zone}.${subnet.subnet_key}" => subnet}

  vpc_id = aws_vpc.first_vpc.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  map_public_ip_on_launch = !each.value.is_private
  tags = {
    Name = "${each.value.is_private ? "Private" : "Public"} Subnet for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = each.value.is_private ? "Private" : "Public"
  }
}

# 3. Create Elastic IPs for each NAT Gateway of each AZs
resource "aws_eip" "eips" {
  depends_on = [ aws_internet_gateway.igw ] # EIPs may require IGW to exist prior to association
  for_each = {
    for subnet in aws_subnet.subnets: subnet.id => subnet if lookup(subnet.tags, "Kind") == "Public"
  }

  vpc = true

  tags = {
    Name = "EIP for Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = each.key
  }
}

resource "aws_nat_gateway" "ngw" {
  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.eips
  ]

  for_each = { for i, eip in aws_eip.eips : "eip-${i}" => eip }

  allocation_id = each.value.allocation_id
  subnet_id = each.value.tags.For

  tags = {
    Name = "Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = each.value.tags.For
  }
}

# Route Table for private subnets
resource "aws_route_table" "private_subnets_to_ngw" {
  depends_on = [
    aws_nat_gateway.ngw
  ]

  for_each = { for i, ngw in aws_nat_gateway.ngw : "ngw-${i}" => ngw }
  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = each.value.id
  }

  tags = {
    Name = "Route Table for private subnet"
    Team = "Acme Squad"
    Environment = "Development"
  }
}
/*
resource "aws_route_table_association" "private_subnet_rt_associations" {
  depends_on = [
    aws_subnet.subnets,
    aws_route_table.private_subnets_to_ngw
  ]

  for_each = {
    for i, rt in aws_route_table.private_subnets_to_ngw: "rt-${i}" => rt
  }

  subnet_id = each.value.tags.For
  route_table_id = each.value.id
}*/

output "first_vpc_arn" {
  value = aws_vpc.first_vpc.arn
}

output "first_vpc_igw_arn" {
  value = aws_internet_gateway.igw.arn
}

output "subnets" {
  description = "Subnet Information"
  value = [ for subnet in aws_subnet.subnets : {
    id = subnet.id
    arn = subnet.arn
    az = subnet.availability_zone
    kind = subnet.tags.Kind
  }]
}

output "nat_eips" {
  description = "Elastic IP allocation ids for Nat Gateway"
  value = [ for eip in aws_eip.eips : eip.allocation_id ]
}

output "nat_gateways" {
  description = "ids for Nat Gateway"
  value = [ for ngw in aws_nat_gateway.ngw : ngw.id ]
}
