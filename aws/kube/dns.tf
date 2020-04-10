data "aws_route53_zone" "kube" {
  name  = var.domain
}
resource "aws_route53_record" "kube" {
  zone_id = data.aws_route53_zone.kube.zone_id
  name    = "${var.name}.${var.domain}."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.kube.public_ip]
}
