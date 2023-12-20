resource "aws_s3_bucket" "my_bucket" {
  bucket = "backend-bucket-of-me"

  tags = {
    Name        = "backend-bucket-of-me"
  }
}