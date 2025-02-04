provider "aws" {
  region     = var.region_name 
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidr1
  availability_zone = "${var.region_name}a"
  tags = {
    Name = var.subnet_name1
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidr2
  availability_zone = "${var.region_name}b"
  tags = {
    Name = var.subnet_name2
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.subnet_cidr3
  availability_zone = "${var.region_name}c"
  tags = {
    Name = var.subnet_name3
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = var.internet_gateway_name
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "subnet1_assoc" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_assoc" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.main_vpc.id
  name   = var.security_group_name

    ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "ec2_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.pem_key_name
  subnet_id                   = aws_subnet.subnet1.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.sg.id]  # Use security group ID, not name
    user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
              echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
              echo 'root:YourStrongPassword' | chpasswd
              systemctl restart sshd
              EOF

  tags = {
    Name = var.instance_name
  }
}