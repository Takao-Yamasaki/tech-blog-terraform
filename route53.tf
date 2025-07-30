# ホストゾーンの作成
resource "aws_route53_zone" "main" {
  name = local.domain
}

# エイリアスレコードの作成
# resource "aws_route53_record" "api" {
#   name                             = "api.${local.domain}"
#   type                             = "A"
#   zone_id                          = aws_route53_zone.main.zone_id

#   alias {
#     evaluate_target_health = true
#     name                   = aws_lb.main.dns_name
#     zone_id                = aws_lb.main.zone_id
#   }
# }
