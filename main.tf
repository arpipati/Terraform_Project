provider "aws" {
  region = var.aws_region
}

module "network" {
  source = "./modules/network"

  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  private_subnet_cidr_block = var.private_subnet_cidr_block
  aws_region = var.aws_region
}

module "instances" {
  source = "./modules/instances"

  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  my_ip_address = var.my_ip_address
  vpc_id = module.network.vpc_id
  public_subnet_id = module.network.public_subnet_id
  private_subnet_id = module.network.private_subnet_id
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

output "control_instance_id" {
  value = module.instances.control_instance_id
}

output "control_instance_sg" {
  value = module.instances.control_instance_security_group_id
}

output "worker_nodes_sg" {
  value = module.instances.worker_nodes_security_group_id
}