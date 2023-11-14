#vpc
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "jenkins-vpc"
  cidr = var.vpc_cidr

  azs = data.aws_availability_zones.azs.names
  # private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]

  private_subnets = var.private_subnets
  public_subnets = var.public_subnets
  #map_public_ip_on_launch = true

  #enable_nat_gateway = true
  #enable_vpn_gateway = true

  enable_dns_hostnames = true
  enable_nat_gateway = true
  single_nat_gateway = true


  tags =  {
        "kubernetes.io/cluster/my-eks-cluster"   =  "shared"

  }

public_subnet_tags = {

  "kubernetes.io/cluster/my-eks-cluster"  =  "shared"
  "kubernetes.io/role/elb"    = 1
}

private_subnet_tags = {

  "kubernetes.io/cluster/my-eks-cluster"  = "shared"
  "kubernetes.io/role/internal-elb"  = 1
}






#   tags = {
#     Name        = "eks-vpc"
#     Terraform   = "true"
#     Environment = "dev"
#   }


#   public_subnet_tags = {

#     Name = "jenkins-subnet"
#   }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"

  cluster_name    = "my-eks-cluster"
  cluster_version = "1.24"


  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # eks_managed_node_group_defaults = {
  #   # We are using the IRSA created below for permissions
  #   # This is a better practice as well so that the nodes do not have the permission,
  #   # only the VPC CNI addon will have the permission
  #   iam_role_attach_cni_policy = false
  # }

  eks_managed_node_groups = {

    nodes = {
        min_size =1
        max_size =3
        desired_size = 2

        instance_type = ["t2.small"]

    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

