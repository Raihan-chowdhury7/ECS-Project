resource "aws_route53_record" "a_alias" {
  zone_id = var.hosted_zone_id
  name    = var.sub_name
  type    = "A"
  
  alias {
    name = var.alb_dns_name
    zone_id = var.alb_zone_id
    evaluate_target_health = false

  }
}