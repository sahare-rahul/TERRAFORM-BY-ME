#in this variable we also putting vallue here
variable "instancetype" {    --we can give any name here
    type = string
    default = "t2.micro"
  
}
#second way we only varialise here and value will pick from terraform.tfvars
variable "instancetype" {
  type = string
}
