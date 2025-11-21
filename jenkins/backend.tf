terraform {
  backend "s3" {
    bucket = "yourBucketname"
    key = "Your tf state file location"
    region = "us-east-1"
  }
}