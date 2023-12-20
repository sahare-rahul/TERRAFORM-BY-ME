provider "aws" {

  region     = "us-east-1"
}



resource "aws_instance" "name" {
 count = length(var.ami) > length(var.instance_type) ? length(var.instance_type) : length(var.ami)  ----here we create 2 instances with 2 deffrent ami  
    ami = element(var.ami, count.index                                                                   and instance types
    instance_type = element(var.instance_type, count.index)
}
