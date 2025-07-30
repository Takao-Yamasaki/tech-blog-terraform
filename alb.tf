# ------------------------------
# ALB
# ------------------------------
# resource "aws_lb" "main" {
#   name = "${local.project}-alb"
#   load_balancer_type = "application"
  
#   ip_address_type = "ipv4"
#   security_groups = [
#     aws_security_group.alb.id
#   ]
#   subnets = [ 
#     aws_subnet.public_subnet_a.id,
#     aws_subnet.public_subnet_c.id
#   ]

#   tags = {
#     "Name" = "${local.project}-alb"
#   }
# }

# ------------------------------
# target group
# ------------------------------
# resource "aws_lb_target_group" "main" {
#   name = "${local.project}-tg"
#   target_type = "ip"
#   vpc_id = aws_vpc.main.id
#   port = 80
#   protocol = "HTTP"
#   protocol_version = "HTTP1"

#   health_check {
#     path = "/health_check"
#     healthy_threshold = 3
#     unhealthy_threshold = 2
#     timeout = 5
#     interval = 15
#     matcher = 200
#     port = "traffic-port"
#     protocol = "HTTP"
#   }

#   depends_on = [ 
#     aws_lb.main
#   ]
# }

# ------------------------------
# Listener for HTTPS
# ------------------------------
# resource "aws_lb_listener" "main" {
#   load_balancer_arn = aws_lb.main.arn
#   port = 443
#   protocol = "HTTPS"
#   ssl_policy = "ELBSecurityPolicy-TLS13-1-2-2021-06"
#   certificate_arn = aws_acm_certificate.api.arn
  
#   # NOTE: リクエストをターゲットグループに転送
#   default_action {
#     type = "forward"
#     target_group_arn = aws_lb_target_group.main.arn
#     order = 1
#   }
# }
