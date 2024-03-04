output "control_instance_security_group_id" {
  value = aws_security_group.control_instance_sg.id
}

output "control_instance_id" {
  value = aws_instance.ControlInstance.id
}

output "worker_nodes_security_group_id" {
  value = aws_security_group.worker_nodes_sg.id
}