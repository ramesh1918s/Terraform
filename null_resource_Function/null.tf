resource "null_resource" "cluster" {
    count = 3


    provisioner "local-exec" {
    command = <<EOH
       echo "${element(aws_instance.public-instances.*.public_ip, count.index)}" >> details && echo "${element(aws_instance.public-instances.*.private_ip, count.index)}" >> details,
    #    cat details | tr -d "/" | tr '"' > updated_details 
    EOH
    }
  
}