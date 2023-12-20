provider "aws" {
  region     = "us-west-2"
  access_key = "my-access-key" 
  secret_key = "my-secret-key"
}

#creating ec2 passing data-soucrce of AMI

resource "aws_instance" "my-instance" {
  ami           = data.aws_ami.ubuntu.id      ---here we called created AMI by data-soucre to call data-sourec allwayes write "data." first,
  instance_type = "t3.micro"                      then in last put attribute .id for fefrence attribute may be defferent as per resource so 
  tags = {
    Name = "HelloWorld"
  }
}
