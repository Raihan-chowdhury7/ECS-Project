output "certificate_arn" {
  value = aws_acm_certificate_validation.this.certificate_arn
}

output "hosted_zone_id" {
  value = var.hosted_zone_id
}