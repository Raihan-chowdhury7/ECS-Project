resource "aws_acm_certificate" "this" {
  domain_name       = var.subdomain_name
  validation_method = var.validation_method

  tags = {
    Name = "acm-cert"
  }

  lifecycle {
    create_before_destroy = true
  }
}

locals {
  validation_option = tolist(aws_acm_certificate.this.domain_validation_options)[0]
}


resource "aws_route53_record" "cert_validation" {
  zone_id = var.hosted_zone_id
  name    = local.validation_option.resource_record_name
  type    = local.validation_option.resource_record_type
  records = [local.validation_option.resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}

