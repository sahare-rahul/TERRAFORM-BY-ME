
#Creating VPC
resource "aws_vpc" "my_vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "my_vpc"
  }
}

#Creating 3 public-subnets

resource "aws_subnet" "public_subnet" {
  count = length(var.public_subnets_cidrs)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.public_subnets_cidrs, count.index)
  map_public_ip_on_launch = true
  availability_zone = data.aws_availability_zones.example.names[count.index]   ----here passing data source with data.

  tags = {
    Name = "public_subnet-${data.aws_availability_zones.example.names[count.index]}"   ----here we are giving tag piblic_subnet with making variable to 
}                                                                                          data.aws_availability_zones.example.names[count.index] and attaching by
                                                                                            -${} 
#Creating internate-gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "internet_gateway"
  }
}

#Creating route-table for public-subnetes

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }

  tags = {
    name = "public_route_table1"
  }
}

#public-subnets association

resource "aws_route_table_association" "public_subnets-association" {
    count = length(var.public_subnets_cidrs)
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_route_table.id

}


#Creating private-subnets
resource "aws_subnet" "private_subnet" {
  count = length(var.private_subnet_cidrs)
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = element(var.private_subnet_cidrs, count.index)
  #map_public_ip_on_launch = 
  availability_zone = data.aws_availability_zones.example.names[count.index]


  tags = {
    name = "private_subnet-${data.aws_availability_zones.example.names[count.index]}"
  }
}
  

#Creating eip for nat-gateway

resource "aws_eip" "my_eip" {
  domain   = "vpc"
}


#Creating nat-gateway
resource "aws_nat_gateway" "my_nat" {
  allocation_id = aws_eip.my_eip.id
  subnet_id     = aws_subnet.public_subnet[0].id

  tags = {
    Name = "my_nat"
  }
}

#Creating private-route-table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.my_nat.id
  }

  tags = {
    name = "private_route_table1"
  }
}


#private subnets-association in private route-table
resource "aws_route_table_association" "private_subnets-association" {
    count = length(var.private_subnet_cidrs)
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_route_table.id

}
