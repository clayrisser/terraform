resource "digitalocean_floating_ip" "rancher" {
  droplet_id = digitalocean_droplet.rancher.id
  region     = digitalocean_droplet.rancher.region
}

resource "cloudflare_record" "rancher" {
  zone_id = var.cloudflare_zone_id
  name    = var.name
  ttl     = 3600
  type    = "A"
  value   = digitalocean_floating_ip.rancher.ip_address
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [
      proxied,
      ttl
    ]
  }
}
