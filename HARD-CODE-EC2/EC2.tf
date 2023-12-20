provider "aws" {
  region     = "us-east-1"   
  access_key = ""
  secret_key = ""
}

#creating aws_instance
resource "aws_instance" "my-first" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = "deployer-key"
  vpc_security_group_ids = [aws_security_group.my-security_group.id]
  tags = {
    name = "my-instance"
  }
}


#creating key-pair
resource "aws_key_pair" "my-key" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDGP1Wsb7rzgWBofkt4qukcmUU3/qpz3+rdqDkU61SjVSHmv5N8jZYVb5GKtSgs9+GW2OUoFQ8eTgrXYId8DlpjTQNoi9jgBPGFcb3ecgxq4qG70Cnitt7p0MJWgg3Bb3rqAwX9M6ikeuBUhhQqdKCM/Dtx8jNHAQj8vXZPewkOXEax4Ty/VwQ2YMax2WdDJSOTO2Ohz1JLAtKJ4jHUraoTWa9RkRk+3JzQ4UFN7icH4kbYE4y/Al9Gm1nC8Q8R9XF5XtnGK5+OhCc6SneSU6B3QiEBaP3WidxjtJiHfZCVQsN4klwFUnNBwKdOVJcRjz4LVGvA12kJ5RBJqOzw+rvaYZUEmQpmWa5pa83l7TxpZzWEfN9FwzptNB+y+Oxkwqxhxwm7cWiRlDmspNCVurHbfCIXsF9TpVFahAItrIBlxowGxl4E/cPjrdipyhSv5+Hr/g6I8hmzilvjPePjn/RcaVF+vx3qFZLxEB+f3KkcsROPbeL3KHzPoGrhTQjM25U= rahul@LAPTOP-SM5G3M6G"
}



#creating and attaching eip to aws_instance
# resource "aws_eip" "my-eip" {
#   instance = aws_instance.my-first.id
#   domain   = "vpc"
# }




#creating security group

resource "aws_security_group" "my-security_group" {
  name        = "my-security_group"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-011a303c9bc15b4f0"


  # Ingress rule 1
  ingress {
    description = "TLS from VPC"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule 2 : Allow SSH access from anywhere
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rule 3 : Allow HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security_group"
  }
}

