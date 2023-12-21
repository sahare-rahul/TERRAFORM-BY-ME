#creating s3 bucket first to store state file in s3

resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "bucket-for-backend"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}





terraform {
  backend "s3" {
    bucket = "bucket-for-backend"
    key    = "Test/s3backend.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    region = "us-east-1"
    access_key = "value"
    secret_key = "value"
  }
}






resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}