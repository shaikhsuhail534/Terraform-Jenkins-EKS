variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "public_subnets" {
    description = "public subnet id"
    type = list(string)
}

<<<<<<< HEAD
variable "private_subnets" {
  description = "private subnets id"
  type = list(string)
=======
variable "instance_type" {
  description = "instance type"
>>>>>>> a90fe93ec1d8998408d3fcf47d887168ecb275d3
}