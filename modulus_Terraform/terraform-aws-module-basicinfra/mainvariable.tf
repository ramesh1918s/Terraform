variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "IGW_name" {
  description = "The name of the Internet Gateway"
  type        = string
}

variable "key_name" {
  description = "The key name for the EC2 instance"
  type        = string
}

variable "public_subnet1_cidr" {
  description = "CIDR block for Subnet 1"
  type        = string
}

variable "public_subnet2_cidr" {
  description = "CIDR block for Subnet 2"
  type        = string
}

variable "public_subnet3_cidr" {
  description = "CIDR block for Subnet 3"
  type        = string
}

variable "public_subnet4_cidr" {
  description = "CIDR block for Subnet 4"
  type        = string
}

variable "public_subnet1_name" {
  description = "Name for Subnet 1"
  type        = string
}

variable "public_subnet2_name" {
  description = "Name for Subnet 2"
  type        = string
}

variable "public_subnet3_name" {
  description = "Name for Subnet 3"
  type        = string
}

variable "public_subnet4_name" {
  description = "Name for Subnet 4"
  type        = string
}

variable "Main_Routing_Table" {
  description = "Name of the main routing table"
  type        = string
}

variable "cidr" {
  description = "CIDR blocks for EC2 instances"
  type        = list(string)
}

variable "environment" {
  description = "Environment for the deployment"
  type        = string
  default     = "dev"
}
