<<<<<<< HEAD
data "aws_availability_zones" "azs" {}
=======
# search for "aws ami terraform"

data "aws_ami" "example" {
  executable_users = ["self"]
  most_recent      = true
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["myami-*"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

#this will automatically configure available zones
data "aws_availability_zones" "azs" {}

>>>>>>> a90fe93ec1d8998408d3fcf47d887168ecb275d3
