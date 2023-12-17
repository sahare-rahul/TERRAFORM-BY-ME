# provider "aws" {
#   region     = "us-east-"
#   access_key = "AKIAZVLFURYRU5S73R4L"
#   secret_key = "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"
# }

#creating ec2 by calling  variale of instance type , we can variablise most of parameters passing in block of "aws_instance"

resource "aws_instance" "my-instance" {
  ami           = "ami-0759f51a90924c166"     
  instance_type = var.my-type        
  tags = { 
    Name = "HelloWorld"
  }
}