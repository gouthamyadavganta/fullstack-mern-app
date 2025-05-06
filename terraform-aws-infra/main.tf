module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-2a", "us-east-2b"]
}
module "eks" {
  source = "./modules/eks"

  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  cluster_name = "devops-eks-cluster"
}
