resource "aws_security_group" "control_instance_sg" {
  name = "Control_Instance_SG"
  description = "Security Group for Controler Instance"
  vpc_id = var.vpc_id

  ingress = [
    {
    description = "SSH"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [var.my_ip_address]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false

    tags = {
      Name = "SSH Ingress from local machine Rule"
    }
  }
  ]

  egress = [
    {
    description = "All"  
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false

    tags = {
      Name = "All traffic outbound rule"
    }
  }
  ]

  tags = {
    Name = "Control_Instance_SG"
  }
}

resource "aws_instance" "ControlInstance" {
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.public_subnet_id
  associate_public_ip_address = true
  security_groups = [aws_security_group.control_instance_sg.id]

  tags = {
    Name = "Control_Instance"
  }
  
}

resource "aws_security_group" "worker_nodes_sg" {
  name = "worker_nodes_sg"
  description = "Worker Nodes Security Group"
  vpc_id = var.vpc_id

  ingress = [
    {
      description = "SSH"
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = []
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = [aws_security_group.control_instance_sg.id]
      self = false

      tags = {
        Name = "SSH Ingress from Control Instance SG"
      }
    }
  ]

  egress = [
    {
      description = "All"  
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids = []
      security_groups = []
      self = false

      tags = {
        Name = "All traffic outbound rule"
      }
    }
  ]

  tags = {
    Name = "Worker_Nodes_SG"
  }
}

resource "aws_instance" "worker_nodes" {
  count = var.instance_count
  ami = var.ami
  instance_type = var.instance_type
  key_name = var.key_name
  subnet_id = var.private_subnet_id
  security_groups = [aws_security_group.worker_nodes_sg.id]

  tags = {
    Name = "Worker_Node_Instance"
  }
}

