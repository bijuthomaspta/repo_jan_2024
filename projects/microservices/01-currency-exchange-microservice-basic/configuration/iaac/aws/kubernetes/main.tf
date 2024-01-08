# aws --version
# aws eks --region us-east-1 update-kubeconfig --name in28minutes-cluster
# Uses default VPC and Subnet. Create Your Own VPC and Private Subnets for Prod Usage.
# terraform-backend-state-in28minutes-123
# AKIA4AHVNOD7OOO6T4KI


terraform {
  backend "s3" {
    bucket = "mybucket" # Will be overridden from build
    key    = "path/to/my/key" # Will be overridden from build
    region = "us-east-1"
  }
}

resource "aws_default_vpc" "default" {

}

data "aws_subnets" "subnets" {
  filter {
    name   = "vpc-id"
    values = [aws_default_vpc.default.id]
  }
}

module "in28minutes-cluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "in28minutes-cluster5856666"
  #cluster_version = "1.23"
  #subnets         = ["subnet-3f7b2563", "subnet-4a7d6a45"] #CHANGE
  subnet_ids = data.aws_subnets.subnets.ids
  vpc_id          = aws_default_vpc.default.id


  #vpc_id         = "vpc-1234556abcdef"
  cluster_endpoint_public_access = true
   eks_managed_node_groups = {
    one = {
      instance_type = "t2.micro"
      max_capacity  = 5
      desired_capacity = 3
      min_capacity  = 3
    }
  }
}


data "aws_eks_cluster" "cluster" {
  name = module.in28minutes-cluster.cluster_name
  depends_on = [module.in28minutes-cluster.cluster_name]
}


data "aws_eks_cluster_auth" "cluster1" {
  name = module.in28minutes-cluster.cluster_name
  depends_on = [module.in28minutes-cluster.cluster_name]
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token = data.aws_eks_cluster_auth.cluster1.token
}


resource "kubernetes_service_account" "example" {
  metadata {
    name      = "biju"
    namespace = "default"
  }
  
  automount_service_account_token = true
}



# We will use ServiceAccount to connect to K8S Cluster in CI/CD mode
# ServiceAccount needs permissions to create deployments 
# and services in default namespace


# Needed to set the default region
provider "aws" {
  region  = "ap-south-1"
}
