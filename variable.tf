variable "vpc_cidr" {
  description = "VPC CIDR"
  type = string
}

variable "public_subnets" {
    description = "public subnet id"
    type = list(string)
}

variable "instance_type" {
  description = "instance type"
}