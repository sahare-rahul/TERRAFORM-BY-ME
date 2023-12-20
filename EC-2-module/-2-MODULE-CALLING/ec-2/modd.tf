module "ec-2" { 
  source =   "git::git@github.com:sahare-rahul/TERRAFORM-BY-ME.git//todays"
                   -----------------------------------------------  -------
                   this is ssh link of my git-hub repository        this is folder within repository where code id stored

  instance_type = "t2.micro"      |   it all are variables which variablise in variable.tf file for ec-2 resource all variables compulsory
  ami = "ami-0fc5d935ebf8bc3bc"   |   to call in module.
}