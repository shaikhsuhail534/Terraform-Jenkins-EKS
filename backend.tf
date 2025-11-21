terraform {
  backend "s3" {
    bucket = "yourbucketname"
    region = "us-east-1"
  }
}