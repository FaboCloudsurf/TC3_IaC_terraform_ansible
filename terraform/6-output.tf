output "instance_public_ip" {
  description = "Public IP of the web server, used by Ansible to connect over SSH"
  value       = aws_instance.TC3_instance[0].public_ip
}