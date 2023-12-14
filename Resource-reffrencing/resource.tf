#creating resource "VPC"
resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}


#creating resource "subnet"

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id      ---here we refering upper created resource "vpc" in subnet,  allways start to refarinf resource to
  cidr_block        = "172.16.10.0/24           with given name  "aws_vpc.my_vpc.id" 
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}