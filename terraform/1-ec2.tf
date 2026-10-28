
resource "aws_instance" "TC3_instance" {
  ami           = "ami-05cf1e9f73fbad2e2"
  instance_type = "t2.micro"
  key_name      = data.aws_key_pair.existing_key.key_name
  #vpc_security_group_ids = [aws_security_group.one_percent_sg.id]
  count = 1

  tags = {
    Name = "${var.project_name}-instance"


  }

}

data "aws_key_pair" "existing_key" {
  key_name = "1_percent_keypair517"
}