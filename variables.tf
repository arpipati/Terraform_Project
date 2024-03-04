variable "aws_region" {
  description = "The AWS region to deploy resources."
  default     = "us-east-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_block" {
  description = "CIDR block for the public subnet"
}

variable "private_subnet_cidr_block" {
  description = "CIDR block for the private subnet"
}

variable "my_ip_address" {
  description = "My_Machine_IP_Address"
}

variable "ami" {
  description = "AMI ID"
}

variable "instance_type" {
  description = "EC2 instance type"
}

variable "key_name" {
  description = "EC2 keypair name"
}

