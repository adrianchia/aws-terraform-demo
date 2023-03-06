# Data resource to find latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name = "name"
    values = ["amzn2-ami-kernel-5*-x86_64-gp2"]
  }

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]

}

# Security Group to allow SSH to bastion through public ip
resource "aws_security_group" "allow_ssh_to_bastion" {
  name = "allow_ssh_to_bastion"
  vpc_id = aws_vpc.first_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_to_bastion" {
  security_group_id = aws_security_group.allow_ssh_to_bastion.id
  description = "SSH to Bastion"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 22
  ip_protocol = "tcp"
  to_port = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_ping_to_bastion" {
  security_group_id = aws_security_group.allow_ssh_to_bastion.id
  description = "Ping to Bastion"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = -1
  ip_protocol = "icmp"
  to_port = -1
}

resource "aws_vpc_security_group_egress_rule" "allow_oubound_connections_from_bastion" {
  security_group_id = aws_security_group.allow_ssh_to_bastion.id
  description = "allow outbound traffic from bastion"
  cidr_ipv4 = "0.0.0.0/0"
  ip_protocol = "-1"
}

# Create an EC2 bastion host to ssh into private instances
resource "aws_instance" "bastion" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  availability_zone = var.az_config[0].az_name
  subnet_id = aws_subnet.az_1_public_subnet_1.id
  associate_public_ip_address = true
  key_name = "adrian-us-east-1"
  vpc_security_group_ids = [
    aws_security_group.allow_ssh_to_bastion.id
  ]
  tags = {
    Name = "Bastion Host for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

resource "aws_security_group" "private_instance_sg" {
  name = "private_instance_sg"
  vpc_id = aws_vpc.first_vpc.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_from_bastion" {
  security_group_id = aws_security_group.private_instance_sg.id

  description = "Allow SSH from bastion"
  ip_protocol = "tcp"
  from_port = 22
  to_port = 22
  referenced_security_group_id = aws_security_group.allow_ssh_to_bastion.id
}

resource "aws_vpc_security_group_ingress_rule" "allow_ping_from_bastion" {
  security_group_id = aws_security_group.private_instance_sg.id

  description = "Allow ping from bastion"
  ip_protocol = "icmp"
  from_port = -1
  to_port = -1
  referenced_security_group_id = aws_security_group.allow_ssh_to_bastion.id
}

resource "aws_vpc_security_group_egress_rule" "allow_outbound_connection_to_public" {
  security_group_id = aws_security_group.private_instance_sg.id

  description = "Allow outbound traffic from private instances"
  ip_protocol = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}

# Create an EC2 instance on az 1 private subnet 1
resource "aws_instance" "private_instance" {
  ami = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"
  availability_zone = var.az_config[0].az_name
  subnet_id = aws_subnet.az_1_private_subnet_1.id
  key_name = "adrian-us-east-1"
  vpc_security_group_ids = [
    aws_security_group.private_instance_sg.id
  ]
  tags = {
    Name = "EC2 instance for Acme Squad"
    Team = "Acme Squad"
    Environment = "Development"
  }
}

output "aws_ec2" {
  value = {
    id = aws_instance.private_instance.id
    ipv4 = aws_instance.private_instance.private_ip
    availability_zone = aws_instance.private_instance.availability_zone
    subnet_id = aws_instance.private_instance.subnet_id
  }
}

output "aws_ec2_bastion" {
  value = {
    id = aws_instance.bastion.id
    ipv4 = aws_instance.bastion.private_ip
    availability_zone = aws_instance.bastion.availability_zone
    subnet_id = aws_instance.bastion.subnet_id
  }
}
