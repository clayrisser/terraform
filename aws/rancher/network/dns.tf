data "aws_route53_zone" "rancher" {
  name  = var.domain
}

resource "aws_route53_record" "rancher" {
  zone_id = data.aws_route53_zone.rancher.zone_id
  name    = "${var.name}.${var.domain}."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.rancher.public_ip]
}

resource "aws_eip" "rancher" {
  instance = aws_instance.rancher.id
  vpc      = true
  tags = {
    Name = var.name
  }
}
