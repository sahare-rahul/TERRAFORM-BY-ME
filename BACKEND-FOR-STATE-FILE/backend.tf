terraform {
  backend "s3" {
    bucket = "backend-bucket-of-me"
    key    = "backend/s3-backend.tfstate"
    region = "us-east-1"
    access_key = "AKIAZVLFURYRYVBWXSW4"
    secret_key = "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"

  }
}
