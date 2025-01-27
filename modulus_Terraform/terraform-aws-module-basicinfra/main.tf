# AWS Provider
provider "aws" {
  region = "us-east-1"
}

module "Testing_Env" {
  source                   = "./modules"
  vpc_cidr                 = "10.8.0.0/16"
  public_subnet1_cidr      = "10.8.1.0/24"
  public_subnet2_cidr      = "10.8.2.0/24"
  public_subnet3_cidr      = "10.8.3.0/24"
  public_subnet4_cidr      = "10.8.4.0/24"
  vpc_name                 = "Test_VPC"
  IGW_name                 = "Test_IGW"
  public_subnet1_name      = "Test_Subnet1"
  public_subnet2_name      = "Test_Subnet2"
  public_subnet3_name      = "Test_Subnet3"
  public_subnet4_name      = "Test_Subnet4"
  Main_Routing_Table       = "Test_Routing_Table"
  key_name                 = "My_Key.pem"
  environment              = "Test"
  cidr                     = ["10.8.1.0/24", "10.8.2.0/24", "10.8.3.0/24", "10.8.4.0/24"]
}

# Creating infra for Dev_Env

# Creating infra for Prod_Env



# module "Dev_Env" {
    
#   source = "./modules"
#   vpc_cidr = "172.16.0.0/16"
#   public_subnet1_cidr = "172.16.1.0/24"
#   public_subnet2_cidr = "172.16.2.0/24"
#   public_subnet3_cidr = "172.16.3.0/24"
#   public_subnet4_cidr = "172.16.4.0/24"
#   vpc_name = "Dev_VCP"
#   IGW_name = "Dev_IGW"
#   public_subnet1_name = "Dev_Env_Subnet1-testing"
#   public_subnet2_name = "Dev_Env_Subnet2-testing"
#   public_subnet3_name = "Dev_Env_Subnet3-testing"
#   public_subnet4_name = "Dev_Env_Subnet4-testing"
#   Main_Routing_Table = "Dev_Env_RT_table"
#   key_name = "My_Key.pem"



# }

# module "Prod_Env" {
#   source = "./modules"
#   vpc_cidr = "194.80.0.0/16"
#   public_subnet1_cidr = "194.80.1.0/24"
#   public_subnet2_cidr = "194.80.2.0/24"
#   public_subnet3_cidr = "194.80.3.0/24"
#   public_subnet4_cidr = "194.80.4.0/24"
#   vpc_name = "Prod_VCP"
#   IGW_name = "Prod_IGW"
#   public_subnet1_name = "Prod_Env_Subnet1-testing"
#   public_subnet2_name = "Prod_Env_Subnet2-testing"
#   public_subnet3_name = "prod_Env_Subnet3-testing"
#   public_subnet4_name = "Prod_Env_Subnet4-testing"
#   Main_Routing_Table = "Prod_Env_RT_table"
#   key_name = "My_Key.pem"   
  
# }

# ONLY UNCOMMENT IF YOU WANT TO DISPLAY BELOW OUTPUTS ON THE SCREEN AFTER APPLY.
# output "subnet1-public" {
#   value = "${module.VPC1.subnet1}"
# }
# output "subnet2-public" {
#   value = "${module.VPC1.subnet2}"
# }
# output "subnet3-public" {
#   value = "${module.VPC1.subnet3}"
# }

# output "subnet4-public" {
#   value = "${module.VPC1.subnet3}"
# }

# output "sgroup" {
#   value = "${module.VPC1.sgroup}"
# }



# resource "aws_instance" "web-1" {
#     ami = "ami-0915e09cc7ceee3ab"
#     availability_zone = "us-east-1a"
#     instance_type = "t2.nano"
#     key_name = "LaptopKey"
#     subnet_id = "${module.VPC1.subnet1}"
#     vpc_security_group_ids = ["${module.VPC1.sgroup}"]
#     associate_public_ip_address = true	
#     tags = {
#         Name = "Server-1"
#         Env = "Prod"
#         Owner = "Ram"
#     }
# }

