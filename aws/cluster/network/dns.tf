data "aws_route53_zone" "entrypoint" {
  name  = var.domain
}

resource "aws_route53_record" "entrypoint" {
  zone_id = data.aws_route53_zone.entrypoint.zone_id
  name    = "${var.name}.${var.domain}."
  type    = "A"
  ttl     = "300"
  records = [aws_eip.entrypoint.public_ip]
}

resource "aws_eip" "entrypoint" {
  instance = aws_instance.entrypoint.id
  vpc      = true
  tags = {
    Name = var.name
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = []
  }
}
