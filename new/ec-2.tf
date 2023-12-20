provider "aws" {

  region     = "us-east-1"
}



resource "aws_instance" "name" {
 count = length(var.ami) > length(var.instance_type) ? length(var.instance_type) : length(var.ami)
    ami = element(var.ami, count.index)
    instance_type = element(var.instance_type, count.index)
}