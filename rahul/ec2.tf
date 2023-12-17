# provider "aws" {
#   region     = "us-east-"
#   access_key = ""
#   secret_key = ""
# }

#creating ec2 by calling  variale of instance type , we can variablise most of parameters passing in block of "aws_instance"

resource "aws_instance" "my-instance" {
  ami           = "ami-0759f51a90924c166"     
  instance_type = var.my-type        
  tags = { 
    Name = "HelloWorld"
  }
}
