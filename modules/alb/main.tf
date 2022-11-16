# APPLICATION LOAD BALANCER
resource "aws_lb" "dep4-alb" {
  name               = "dep4-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.elb_sg_id]
  subnets            = [var.subnet1_id, var.subnet2_id]
  ip_address_type    = "ipv4"
  enable_deletion_protection = true

  tags = {
    Environment = "production"
  }
}

# INSTANCE TARGET GROUPS
resource "aws_lb_target_group" "dep4-alb-tg1" {
  name     = "dep4-alb-tg1"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = "/"
    port = 8000
  }
}

resource "aws_lb_listener" "dep4-alb-listener" {
  load_balancer_arn = aws_lb.dep4-alb.arn
  port              = "8000"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.front_end.arn
  }
}