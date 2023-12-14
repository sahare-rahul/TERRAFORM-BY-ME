provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key"
  secret_key = "my-secret-key"
}

#creating ec2 by calling  variale of instance type , we can variablise most of parameters passing in block of "aws_instance"

resource "aws_instance" "my-instance" {
  ami           = data.aws_ami.ubuntu.id     
  instance_type = var.instance_type        -----any varialbe call like that first allways put "var."

  tags = {
    Name = "HelloWorld"
  }
}