module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "8.0.0"

  name               = "web-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets           = module.vpc.public_subnets

  target_groups = [
    {
      name     = "web-target-group"
      port     = 80
      protocol = "HTTP"
    }
  ]

  listeners = [
    {
      port     = 80
      protocol = "HTTP"
      action_type = "forward"
      target_group_index = 0
    }
  ]
}
