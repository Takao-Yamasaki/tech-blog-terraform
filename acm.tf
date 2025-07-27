# ------------------------------
# ACM for api
# ------------------------------
resource "aws_acm_certificate" "api" {
  domain_name = "api.${local.domain}"
  validation_method = "DNS"
  
  depends_on = [ 
    aws_route53_zone.main
  ]
}

# ------------------------------
# DNS Validation for api
# ------------------------------
resource "aws_route53_record" "api_validation" {
  for_each = {
    for dvo in aws_acm_certificate.api.domain_validation_options : dvo.domain_name => {
      name = dvo.resource_record_name
      type = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  }

  allow_overwrite = true  
  zone_id = aws_route53_zone.main.id
  name = each.value.name
  type = each.value.type
  ttl = 600
  records = [each.value.record]
}

resource "aws_acm_certificate_validation" "api" {
  certificate_arn = aws_acm_certificate.api.arn
  validation_record_fqdns = [for record in aws_route53_record.api_validation : record.fqdn]
}
