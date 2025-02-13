resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true

  tags = {
    Name = var.vpc_name
    ModuleCreatedBy = "Ramesh Muddappagari"
  }
}

resource "aws_internet_gateway" "default" {
  vpc_id = aws_vpc.default.id

  tags = {
    Name = var.IGW_name
  }
}

resource "aws_subnet" "subnet1-public" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet1_cidr
  availability_zone       = "us-east-1a"

  tags = {
    Name = var.public_subnet1_name
  }
}

resource "aws_subnet" "subnet2-public" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet2_cidr
  availability_zone       = "us-east-1b"

  tags = {
    Name = var.public_subnet2_name
  }
}

resource "aws_subnet" "subnet3-public" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet3_cidr
  availability_zone       = "us-east-1c"

  tags = {
    Name = var.public_subnet3_name
  }
}

resource "aws_subnet" "subnet4-public" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = var.public_subnet4_cidr
  availability_zone       = "us-east-1d"

  tags = {
    Name = var.public_subnet4_name
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.default.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.default.id
  }

  tags = {
    Name = var.Main_Routing_Table
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet1-public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow all inbound traffic"
  vpc_id      = aws_vpc.default.id

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

resource "aws_instance" "web" {
  count                  = length(var.cidr)
  ami                    = "ami-05576a079321f21f8"
  instance_type          = var.environment == "dev" ? "t2.nano" : "t2.micro"
  key_name               = var.key_name
  subnet_id              = aws_subnet.subnet1-public.id
  vpc_security_group_ids = [aws_security_group.allow_all.id]

  tags = {
    Name = "Test_Instance"
    Environment = var.environment
  }
}
