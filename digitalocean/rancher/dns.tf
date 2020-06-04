resource "digitalocean_floating_ip" "rancher" {
  droplet_id = digitalocean_droplet.rancher.id
  region     = digitalocean_droplet.rancher.region
}

resource "digitalocean_record" "rancher" {
  domain = var.domain
  name = "${var.name}."
  type = "A"
  value = digitalocean_floating_ip.rancher.ip_address
}
