provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_vpc" "RS_Vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "RS_Vpc"
  }
}

resource "aws_subnet" "RS_Subnet1a" {
  vpc_id                  = aws_vpc.RS_Vpc.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = true
  tags = {
    Name = "RS_Subnet1a"
  }
}

resource "aws_subnet" "RS_Subnet2b" {
  vpc_id                  = aws_vpc.RS_Vpc.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = "us-east-1b"
  map_public_ip_on_launch = true
  tags = {
    Name = "RS_Subnet2b"
  }
}

resource "aws_subnet" "RS_Subnet3c" {
  vpc_id                  = aws_vpc.RS_Vpc.id
  cidr_block              = var.subnet3_cidr
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true
  tags = {
    Name = "RS_Subnet3c"
  }
}

resource "aws_internet_gateway" "RS_INGW" {
  vpc_id = aws_vpc.RS_Vpc.id
  tags = {
    Name = "RS_INGW"
  }
}

resource "aws_route_table" "RS_RT" {
  vpc_id = aws_vpc.RS_Vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.RS_INGW.id
  }

  tags = {
    Name = "RS_RT"
  }
}

resource "aws_route_table_association" "subnet1" {
  subnet_id      = aws_subnet.RS_Subnet1a.id
  route_table_id = aws_route_table.RS_RT.id
}

resource "aws_route_table_association" "subnet2" {
  subnet_id      = aws_subnet.RS_Subnet2b.id
  route_table_id = aws_route_table.RS_RT.id
}

resource "aws_route_table_association" "subnet3" {
  subnet_id      = aws_subnet.RS_Subnet3c.id
  route_table_id = aws_route_table.RS_RT.id
}

resource "aws_security_group" "RS_SG" {
  vpc_id = aws_vpc.RS_Vpc.id

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

  tags = {
    Name = "RS_SG"
  }
}

resource "aws_instance" "My_Server" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = aws_subnet.RS_Subnet1a.id
  vpc_security_group_ids = [aws_security_group.RS_SG.id]
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              sudo dnf install -y nginx
              sudo systemctl start nginx
              sudo systemctl enable nginx
              echo 'PermitRootLogin yes' >> /etc/ssh/sshd_config
              echo 'PasswordAuthentication yes' >> /etc/ssh/sshd_config
              echo 'root:YourStrongPassword' | chpasswd
              systemctl restart sshd
              EOF

  tags = {
    Name = "My_Server"
  }
}