module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "my-vpc"
  cidr = "var.vpc_cidr"

  azs             = data.aws_availability_zones.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  

  default_vpc_enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
  }

  public_subnet_tags = {
      "kubernetes.io/cluster/my-eks-cluster" = "shared"
      "kubernetes.io/role/elb" = "shared"
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/my-eks-cluster" = "shared"
      "kubernetes.io/role/internal-elb" = "shared"
  }
} 

#search for terraform eks module

module "eks" {
  source  = "terraform-aws-modules/eks/aws"


  name               = "my-eks-cluster"
  kubernetes_version = "1.24"


  compute_config = {
    enabled    = true
    node_pools = ["general-purpose"]
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets
  

  eks_managed_node_groups = {
    node = {}
    min_size = 1
    max_size = 3
    desired_size = 2

    instance_type = ["t2.small"]
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}
