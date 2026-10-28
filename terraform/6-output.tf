output "instance_public_ip" {
  description = "Public IP of the web server, used by Ansible to connect over SSH"
  value       = aws_instance.TC3_instance.public_ip
}

# 6-output.tf
output "instance_id" {
  description = "EC2 instance ID, used by Ansible to connect through SSM"
  value       = aws_instance.TC3_instance.id
}