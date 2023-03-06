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
resource "aws_subnet" "az_1_private_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[0].subnets[0].cidr_block
  availability_zone = var.az_config[0].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[0].az_name}"
  }
}

resource "aws_subnet" "az_1_public_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[0].subnets[1].cidr_block
  availability_zone = var.az_config[0].az_name
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Public"
    AZ = "${var.az_config[0].az_name}"
  }
}

resource "aws_subnet" "az_1_private_subnet_2" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[0].subnets[2].cidr_block
  availability_zone = var.az_config[0].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 2 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[0].az_name}"
  }
}

resource "aws_subnet" "az_2_private_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[1].subnets[0].cidr_block
  availability_zone = var.az_config[1].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[1].az_name}"
  }
}

resource "aws_subnet" "az_2_public_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[1].subnets[1].cidr_block
  availability_zone = var.az_config[1].az_name
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Public"
    AZ = "${var.az_config[1].az_name}"
  }
}

resource "aws_subnet" "az_2_private_subnet_2" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[1].subnets[2].cidr_block
  availability_zone = var.az_config[1].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 2 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[1].az_name}"
  }
}

resource "aws_subnet" "az_3_private_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[2].subnets[0].cidr_block
  availability_zone = var.az_config[2].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[2].az_name}"
  }
}

resource "aws_subnet" "az_3_public_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[2].subnets[1].cidr_block
  availability_zone = var.az_config[2].az_name
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Public"
    AZ = "${var.az_config[2].az_name}"
  }
}

resource "aws_subnet" "az_3_private_subnet_2" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[2].subnets[2].cidr_block
  availability_zone = var.az_config[2].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 2 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[2].az_name}"
  }
}

resource "aws_subnet" "az_4_private_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[3].subnets[0].cidr_block
  availability_zone = var.az_config[3].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[3].az_name}"
  }
}

resource "aws_subnet" "az_4_public_subnet_1" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[3].subnets[1].cidr_block
  availability_zone = var.az_config[3].az_name
  map_public_ip_on_launch = true
  tags = {
    Name = "Public Subnet 1 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Public"
    AZ = "${var.az_config[3].az_name}"
  }
}

resource "aws_subnet" "az_4_private_subnet_2" {
  vpc_id = aws_vpc.first_vpc.id
  cidr_block = var.az_config[3].subnets[2].cidr_block
  availability_zone = var.az_config[3].az_name
  #map_public_ip_on_launch = var.az_config[0].subnets[0].is_private
  tags = {
    Name = "Private Subnet 2 for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
    Kind = "Private"
    AZ = "${var.az_config[3].az_name}"
  }
}


# 3. Create Elastic IPs for each NAT Gateway of each AZs
resource "aws_eip" "az_1_eip" {
  depends_on = [ aws_internet_gateway.igw ] # EIPs may require IGW to exist prior to association

  vpc = true

  tags = {
    Name = "EIP for Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = aws_subnet.az_1_public_subnet_1.availability_zone
  }
}

resource "aws_eip" "az_2_eip" {
  depends_on = [ aws_internet_gateway.igw ] # EIPs may require IGW to exist prior to association

  vpc = true

  tags = {
    Name = "EIP for Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = aws_subnet.az_2_public_subnet_1.availability_zone
  }
}

resource "aws_eip" "az_3_eip" {
  depends_on = [ aws_internet_gateway.igw ] # EIPs may require IGW to exist prior to association

  vpc = true

  tags = {
    Name = "EIP for Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = aws_subnet.az_3_public_subnet_1.availability_zone
  }
}

resource "aws_eip" "az_4_eip" {
  depends_on = [ aws_internet_gateway.igw ] # EIPs may require IGW to exist prior to association

  vpc = true

  tags = {
    Name = "EIP for Nat Gateway"
    Team = "Acme Squad"
    Environment = "Development"
    For = aws_subnet.az_4_public_subnet_1.availability_zone
  }
}

resource "aws_nat_gateway" "az_1_ngw" {
  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.az_1_eip,
    aws_subnet.az_1_public_subnet_1
  ]


  allocation_id = aws_eip.az_1_eip.allocation_id
  subnet_id = aws_subnet.az_1_public_subnet_1.id

  tags = {
    Name = "Nat Gateway for ${aws_subnet.az_1_public_subnet_1.availability_zone}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

resource "aws_nat_gateway" "az_2_ngw" {
  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.az_2_eip,
    aws_subnet.az_2_public_subnet_1
  ]


  allocation_id = aws_eip.az_2_eip.allocation_id
  subnet_id = aws_subnet.az_2_public_subnet_1.id

  tags = {
    Name = "Nat Gateway for ${aws_subnet.az_2_public_subnet_1.availability_zone}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

resource "aws_nat_gateway" "az_3_ngw" {
  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.az_3_eip,
    aws_subnet.az_3_public_subnet_1
  ]


  allocation_id = aws_eip.az_3_eip.allocation_id
  subnet_id = aws_subnet.az_3_public_subnet_1.id

  tags = {
    Name = "Nat Gateway for ${aws_subnet.az_3_public_subnet_1.availability_zone}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

resource "aws_nat_gateway" "az_4_ngw" {
  depends_on = [
    aws_internet_gateway.igw,
    aws_eip.az_4_eip,
    aws_subnet.az_4_public_subnet_1
  ]


  allocation_id = aws_eip.az_4_eip.allocation_id
  subnet_id = aws_subnet.az_4_public_subnet_1.id

  tags = {
    Name = "Nat Gateway for ${aws_subnet.az_4_public_subnet_1.availability_zone}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}


# Route Table for AZ 1 private subnet 1
resource "aws_route_table" "rt_az_1_private_1" {
  depends_on = [
    aws_nat_gateway.az_1_ngw
  ]

  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az_1_ngw.id
  }

  tags = {
    Name = "Route Table for private subnet ${aws_subnet.az_1_private_subnet_1.id}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

# Route Table for AZ 2 private subnet 1
resource "aws_route_table" "rt_az_2_private_1" {
  depends_on = [
    aws_nat_gateway.az_2_ngw
  ]

  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az_2_ngw.id
  }

  tags = {
    Name = "Route Table for private subnet ${aws_subnet.az_2_private_subnet_1.id}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

# Route Table for AZ 3 private subnet 1
resource "aws_route_table" "rt_az_3_private_1" {
  depends_on = [
    aws_nat_gateway.az_3_ngw
  ]

  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az_3_ngw.id
  }

  tags = {
    Name = "Route Table for private subnet ${aws_subnet.az_3_private_subnet_1.id}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

# Route Table for AZ 4 private subnet 1
resource "aws_route_table" "rt_az_4_private_1" {
  depends_on = [
    aws_nat_gateway.az_4_ngw
  ]

  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.az_4_ngw.id
  }

  tags = {
    Name = "Route Table for private subnet ${aws_subnet.az_4_private_subnet_1.id}"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

# Route table associations for az 1 private subnet 1
resource "aws_route_table_association" "rta_az1_private1" {
  depends_on = [
    aws_subnet.az_1_private_subnet_1,
    aws_route_table.rt_az_1_private_1
  ]

  subnet_id = aws_subnet.az_1_private_subnet_1.id
  route_table_id = aws_route_table.rt_az_1_private_1.id
}

# Route table associations for az 2 private subnet 1
resource "aws_route_table_association" "rta_az2_private1" {
  depends_on = [
    aws_subnet.az_2_private_subnet_1,
    aws_route_table.rt_az_2_private_1
  ]

  subnet_id = aws_subnet.az_2_private_subnet_1.id
  route_table_id = aws_route_table.rt_az_2_private_1.id
}

# Route table associations for az 3 private subnet 1
resource "aws_route_table_association" "rta_az3_private1" {
  depends_on = [
    aws_subnet.az_3_private_subnet_1,
    aws_route_table.rt_az_3_private_1
  ]

  subnet_id = aws_subnet.az_3_private_subnet_1.id
  route_table_id = aws_route_table.rt_az_3_private_1.id
}

# Route table associations for az 4 private subnet 1
resource "aws_route_table_association" "rta_az4_private1" {
  depends_on = [
    aws_subnet.az_4_private_subnet_1,
    aws_route_table.rt_az_4_private_1
  ]

  subnet_id = aws_subnet.az_4_private_subnet_1.id
  route_table_id = aws_route_table.rt_az_4_private_1.id
}

# Route Table for public
resource "aws_route_table" "rt_public" {
  depends_on = [
    aws_internet_gateway.igw
  ]

  vpc_id = aws_vpc.first_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Route Table for public subnets"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

# Route table associations for az 1 public subnet 1
resource "aws_route_table_association" "rta_az1_public1" {
  depends_on = [
    aws_subnet.az_1_public_subnet_1,
    aws_route_table.rt_public
  ]

  subnet_id = aws_subnet.az_1_public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

# Route table associations for az 2 public subnet 1
resource "aws_route_table_association" "rta_az2_public1" {
  depends_on = [
    aws_subnet.az_2_public_subnet_1,
    aws_route_table.rt_public
  ]

  subnet_id = aws_subnet.az_2_public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

# Route table associations for az 3 public subnet 1
resource "aws_route_table_association" "rta_az3_public1" {
  depends_on = [
    aws_subnet.az_3_public_subnet_1,
    aws_route_table.rt_public
  ]

  subnet_id = aws_subnet.az_3_public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

# Route table associations for az 4 public subnet 1
resource "aws_route_table_association" "rta_az4_public1" {
  depends_on = [
    aws_subnet.az_4_public_subnet_1,
    aws_route_table.rt_public
  ]

  subnet_id = aws_subnet.az_4_public_subnet_1.id
  route_table_id = aws_route_table.rt_public.id
}

output "first_vpc_arn" {
  value = aws_vpc.first_vpc.arn
}

output "first_vpc_igw_arn" {
  value = aws_internet_gateway.igw.arn
}
