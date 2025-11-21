terraform {
  backend "s3" {
    bucket = "your bucket name"
    key = "this is where you store your tf state file"
    region = "us-east-1"
  }
}