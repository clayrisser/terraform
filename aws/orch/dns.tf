resource "cloudflare_record" "orch" {
  domain  = "${var.domain}"
  name    = "${var.name}"
  value   = "${aws_eip.orch.public_ip}"
  type    = "A"
  ttl     = 300
}