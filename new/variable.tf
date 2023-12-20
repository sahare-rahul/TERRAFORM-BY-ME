variable "ami" {
    type = list(string)
  default = [ "ami-079db87dc4c10ac91", "ami-0fc5d935ebf8bc3bc" ]
}


variable "instance_type" {
    type = list(string)
  default = [ "t2.micro", "t2.large" ]
}