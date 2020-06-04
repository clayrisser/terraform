resource "digitalocean_droplet" "rancher" {
  image              = "rancheros"
  name               = "${var.name}-rancher"
  private_networking = true
  region             = var.region
  size               = "s-2vcpu-2gb"
  ssh_keys           = ["${digitalocean_ssh_key.ssh_key.id}"]
  user_data          = data.template_file.rancher_cloudconfig.rendered
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = []
  }
}

resource "digitalocean_volume" "rancher" {
  description             = "rancher volume"
  initial_filesystem_type = "xfs"
  name                    = var.name
  region                  = digitalocean_droplet.rancher.region
  size                    = 10
}

resource "digitalocean_volume_attachment" "rancher" {
  droplet_id = digitalocean_droplet.rancher.id
  volume_id  = digitalocean_volume.rancher.id
}

data "template_file" "rancher_cloudconfig" {
  template = file("cloud-config.yml")
  vars = {
    docker_version  = var.docker_version
    domain          = var.domain
    name            = var.name
    rancher_version = var.rancher_version
  }
}
