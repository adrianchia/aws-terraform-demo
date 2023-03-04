# 1. Creates a vpc for our demo
resource "aws_vpc" "first_vpc" {
  cidr_block = "10.0.0.0/16" # = 65536 IPs from 10.0.0.0 to 10.0.255.255 (note, some IPs are reserved, so actual usable IP count may be less)
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
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



output "first_vpc_arn" {
  value = aws_vpc.first_vpc.arn
}

output "first_vpg_igw_arn" {
  value = aws_internet_gateway.igw.arn
}
