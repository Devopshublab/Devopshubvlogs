resource "aws_security_group" "allow_sg" {
  name        = "${var.name}-SG"
  description = "Allow tls inbound traffic"

  ingress {
    description = "SSH from VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  ingress {
    description = "Jfrog Port from VPC"
    from_port   = 8082
    to_port     = 8082
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }
  
  ingress {
    description = "SonarQube Port from VPC"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = var.cidr_blocks
  }

  egress {
    description      = "TLS from VPC"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"] #tfsec:ignore:aws-ec2-no-public-egress-sgr
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.name}-SG",
    ENV  = var.ENV
  }
}
