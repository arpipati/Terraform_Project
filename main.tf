provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"

  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
}

# Reference Outputs from the Network module
output "vpc_id" {
    value = module.network.vpc_id
}

output "public_subnet_id" {
    value = module.network.public_subnet_id
}

output "private_subnet_id" {
    value = module.network.private_subnet_id
}