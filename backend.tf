terraform {
  backend "s3" {
<<<<<<< HEAD
    bucket = "yourbucketname"
=======
    bucket = "your bucket name"
    key = "this is where you store your tf state file"
>>>>>>> a90fe93ec1d8998408d3fcf47d887168ecb275d3
    region = "us-east-1"
  }
}