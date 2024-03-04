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

variable "vpc_id" {
  description = "The ID of the VPC"
}

variable "public_subnet_id" {
  description = "Public Subnet ID"
}

variable "private_subnet_id" {
  description = "ID of the private subnet where worker instances will be launched"
}

variable "instance_count" {
  description = "Number of worker instances to create"
  default     = 2 # Default to 2 instances
}