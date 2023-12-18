provider "aws" {
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}

# Creating one VPC

resource "aws_vpc" "my_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

#Creating public-subnetes
resource "aws_subnet" "public_subnet1" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"   -----this required to assign public ip to instance ,which will be launch in public_subnete1

  tags = {
    Name = "public_subnet1"
  }
}


resource "aws_subnet" "public_subnet2" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "public_subnet2"
  }
}


#creating security group

resource "aws_security_group" "my_security_group" {
  name        = "my_security_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.my_vpc.id

   ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  # Second ingress rule for SSH access from a specific IP range
  ingress {
    description = "SSH from specific IP range"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  

  }
}


#creating internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}


#Creating public route-table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
  tags = {
    Name = "public_route_table"
  }
}


#associating public-subnete1 with route-table
resource "aws_route_table_association" "public_subnet1" {
  subnet_id      = aws_subnet.public_subnet1.id
  route_table_id = aws_route_table.public_route_table.id

}

#associating public-subnete1 with route-table
resource "aws_route_table_association" "public_subnet2" {
  subnet_id      = aws_subnet.public_subnet2.id
  route_table_id = aws_route_table.public_route_table.id
}

#creating key-pair
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGP1Wsb7rzgWBofkt4qukcmUU3/qpz3+rdqDkU61SjVSHmv5N8jZYVb5GKtSgs9+GW2OUoFQ8eTgrXYId8DlpjTQNoi9jgBPGFcb3ecgxq4qG70Cnitt7p0MJWgg3Bb3rqAwX9M6ikeuBUhhQqdKCM/Dtx8jNHAQj8vXZPewkOXEax4Ty/VwQ2YMax2WdDJSOTO2Ohz1JLAtKJ4jHUraoTWa9RkRk+3JzQ4UFN7icH4kbYE4y/Al9Gm1nC8Q8R9XF5XtnGK5+OhCc6SneSU6B3QiEBaP3WidxjtJiHfZCVQsN4klwFUnNBwKdOVJcRjz4LVGvA12kJ5RBJqOzw+rvaYZUEmQpmWa5pa83l7TxpZzWEfN9FwzptNB+y+Oxkwqxhxwm7cWiRlDmspNCVurHbfCIXsF9TpVFahAItrIBlxowGxl4E/cPjrdipyhSv5+Hr/g6I8hmzilvjPePjn/RcaVF+vx3qFZLxEB+f3KkcsROPbeL3KHzPoGrhTQjM25U= rahul@LAPTOP-SM5G3M6G"
  }


#creating aws instance
resource "aws_instance" "web" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.public_subnet1.id
  key_name = "deployer-key"
  tags = {
    Name = "HelloWorld"
  }
}


#Creating private-subnete
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.3.0/24"
  tags = {
    Name = "private_subnet1"
  }
}
   
   #creating eip

   
resource "aws_eip" "my_eip" {
  domain   = "vpc"
}


#Creating nat-gateway
resource "aws_nat_gateway" "my_nat_gateway" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet1.id

  tags = {
    name = "my_nat_gateway1"
  }

}


#Creating private-route-table

resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.my_nat_gateway.id
  }
  tags = {
    Name = "private_route_table"
  }
}


#private route table association
resource "aws_route_table_association" "private_subnet" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_route_table.id
}


#creating aws instance in pvt subnetes

resource "aws_instance" "web1" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.private_subnet.id

  tags = {
    Name = "web1"
  }
}


