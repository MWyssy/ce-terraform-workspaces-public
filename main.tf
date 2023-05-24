terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

locals {
  environment = terraform.workspace
}

module "vars" {
  source      = "./modules/vars"
  environment = local.environment
}

resource "aws_vpc" "vpc_main" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name      = module.vars.env.vpc_name
    ManagedBy = "Terraform"
    UsedBy    = module.vars.env.used_by
  }
}

