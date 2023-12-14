resource "aws_instance" "my-instance" {
  ami           = "ami-0c55b159cbfafe1f0"  
  instance_type = "t2.micro"  
}


# to print any parameter on terminal we use output

output "instance_type" {                   here we printind instance type   "here we can giv any name"
  value = aws_instance.my-instance_type
}

output "ami_id" {
  value = aws_instance.my-instance.ami
}