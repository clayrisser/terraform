data "aws_route53_zone" "dedicated_entrypoint" {
  name  = var.domain
}
resource "aws_route53_record" "dedicated_entrypoint" {
  zone_id = data.aws_route53_zone.dedicated_entrypoint.zone_id
  name    = "${var.name}.${var.domain}."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.dedicated_entrypoint.public_ip]
}
