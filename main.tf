#VPC
#search for terraform vpc module
#we are not going to create a private subnet and create only one public subnet

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "var.vpc_cidr"

  azs             = data.aws_availability_zones.azs
  public_subnets  = var.public_subnets
  map_public_ip_on_launch = true

  default_vpc_enable_dns_hostnames = true

  tags = {
    Terraform = "jenkins-vpc"
    Environment = "dev"
  }
} 

#=================================================
#SECURITY GROUP

module "vote_service_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "jenkins-sg"
  description = "Security group for jenkins user"
  vpc_id      = "module.vpc.vpc_id"


  ingress_with_cidr_blocks = [
    {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      description = "HTTP"
      cidr_blocks = "0.0.0.0/0"
    },
    {
     from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  egress_with_cidr_blocks = {
    from_port   = 0
      to_port     = 0
      protocol    = "-1"
      description = "SSH"
      cidr_blocks = "0.0.0.0/0"
  }
}


#EC2 Instance

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name = "jenkins-server"

  instance_type = "var.instance_type"
  key_name      = "yourkeypair"
  monitoring    = true
  vpc_security_group_ids = [module.sg.security_group_id]
  subnet_id     = module.vpc.public_subnets[0]
  associate_public_ip_address = true
  availability_zone = data.aws_availability_zones.azs[0]

  # A user data is something that executes
  #when your ec2 instance starts and is running
  user_data = file("jenkins-install.sh")

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}