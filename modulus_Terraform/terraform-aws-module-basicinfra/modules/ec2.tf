
resource "aws_instance" "web-1" {
  count                    = length(var.cidr)
  ami                      = "ami-05576a079321f21f8"
  availability_zone         = "us-east-1a"
  instance_type             = "t2.nano"
  key_name                 = "LaptopKey"
  subnet_id                = element(module.Testing_Env.subnet_ids, count.index) # Use subnet_ids from the module
  vpc_security_group_ids   = [element(module.Testing_Env.sgroup, 0)] # Get the first security group from the module
  associate_public_ip_address = true
  
  tags = {
    Name  = "Server-${count.index + 1}"
    Env   = "Prod"
    Owner = "Ram"
  }
}

