# ALB SECURITY GROUP
resource "aws_security_group" "dep4-alb-flask" {
  name        = "dep4-alb-flask"
  description = "Port 8000 open"
  vpc_id      = aws_vpc.deployment4-vpc.id

  ingress {
      from_port   = 8000
      to_port     = 8000
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
    Name = "dep4-alb-sg"
  }
}


# EC2 SECURITY GROUP
resource "aws_security_group" "dep4-sg" {
    name            = lookup(var.ec2-properties, "sg_name")
    description     = lookup(var.ec2-properties, "sg_name")
    vpc_id          = var.vpc_id
    
    // To allow SSH connection
    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    // To allow connection to Gunicorn
    ingress {
        from_port   = 8000
        to_port     = 8000
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
        "Name" : "specifically for deployment4"
        "Terraform" : "true"
    }
}
