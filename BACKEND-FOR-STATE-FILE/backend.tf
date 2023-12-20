terraform {
  backend "s3" {
    bucket = "backend-bucket-of-me"                 ----bucket-name
    key    = "backend/s3-backend.tfstate"           ----here  "backend"  is folder in s3-bucket and s3-backend.tfstate is file name  
    region = "us-east-1"
    access_key = "AKIAZVLFURYRYVBWXSW4"
    secret_key = "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"

  }
}
