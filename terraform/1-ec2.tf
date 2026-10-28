
resource "aws_instance" "TC3_instance" {
  ami           = "ami-05cf1e9f73fbad2e2"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.TC3_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.TC3_instance_profile.name # S3 read + SSM access
  tags = {
    Name = "${var.project_name}-instance"
    Environment = var.environment


  }

}

data "aws_key_pair" "existing_key" {
  key_name = "1_percent_keypair517"
}