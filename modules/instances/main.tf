resource "aws_instance" "master_instance" {
  ami           = "ami-00a9282ce3b5ddfb1" # Replace with your desired AMI
  instance_type = var.instance_type
  subnet_id     = module.network.master_subnet_id
  key_name      = "apatil-aws-keypair"     # Replace with your SSH key name
  security_groups = [module.network.master_sg_id]

  # You can add user_data here to configure the master instance if needed
}

# Define worker instances and their configuration here
