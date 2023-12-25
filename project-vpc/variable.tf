#vpc variablise
 variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
   
 }


 #variablising for public_subnets cidrs

 variable "public_subnets_cidrs" {
    type = list(string)
   default = [ "10.0.1.0/24","10.0.2.0/24","10.0.3.0/24" ]
 }



 #Variablising for private_subnets cidrs

 variable "private_subnet_cidrs" {
    type = list(string)
   default = [ "10.0.4.0/24","10.0.5.0/24","10.0.6.0/24" ]
 }