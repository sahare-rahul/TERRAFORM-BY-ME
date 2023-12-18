module "ec-2" { 
  source = "../../todays"
  instance_type = "t2.micro"
  ami = "ami-0fc5d935ebf8bc3bc"
}