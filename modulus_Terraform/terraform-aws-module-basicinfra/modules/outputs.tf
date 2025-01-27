# output "subnet1" {
#   value = "${aws_subnet.subnet1-public.id}"
# }

# output "subnet2" {
#   value = "${aws_subnet.subnet2-public.id}"
# }

# output "subnet3" {
#   value = "${aws_subnet.subnet3-public.id}"
# }

# output "subnet4" {
#   value = "${aws_subnet.subnet4-public.id}"
# }

# output "sgroup" {
#   value = "${aws_security_group.allow_all.id}"
# }


# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.default.id
# }

# output "vpc_name" {
#   description = "The name of the VPC"
#   value       = aws_vpc.default.tags["Name"]
# }


output "vpc_id" {
  value = aws_vpc.default.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.subnet1-public.id,
    aws_subnet.subnet2-public.id,
    aws_subnet.subnet3-public.id,
    aws_subnet.subnet4-public.id,
  ]
}

output "security_group_id" {
  value = aws_security_group.allow_all.id
}
