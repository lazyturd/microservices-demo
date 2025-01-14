terraform {
  required_providers {
   aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
     kubernetes = {
      source = "hashicorp/kubernetes"
      version = ">= 1.19"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.0.1"
    }
  }
}


provider "aws" {
  region     = "${var.region}"
}

provider "helm" {
  kubernetes {
   host                   = module.eks.cluster_endpoint
   cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

   exec {
     api_version = "client.authentication.k8s.io/v1beta1"
     command     = "aws"
     # This requires the awscli to be installed locally where Terraform is executed
     args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
    }
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)

  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    # This requires the awscli to be installed locally where Terraform is executed
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}