#ALB this is the PUBLIC entry point, so its rules are deliberately open:
resource "aws_security_group" "TC3_sg" {
  name        = "${var.project_name}-web-sg"
  description = "web sg"

  #HTTP port 80 (HyperText Transfer Protocol) is the basic "language" browsers and servers use to talk to each other.
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project_name}-sg"
    Environment = var.environment
  }

}
