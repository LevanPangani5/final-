terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.86.1"
    }
  }
}
 
provider "aws" {
  region = "eu-central-1"
}


terraform {
  backend "local" {
    path = "./terraform.tfstate"
  }
}

locals {
  environment_name = "d"
}

module "web_app" {

vpc_cidr = var.vpc_cidr
  source = "../../modules/network/"
  sbn_1a_priv_cidr =  var.sbn_1a_priv_cidr
  sbn_1b_priv_cidr = var.sbn_1b_priv_cidr
  
  sbn_1a_pub_cidr = var.sbn_1a_pub_cidr
  sbn_1b_pub_cidr = var.sbn_1b_pub_cidr

  env = local.environment_name
}
