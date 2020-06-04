resource "tls_private_key" "rancher" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "digitalocean_ssh_key" "ssh_key" {
  name       = var.name
  public_key = tls_private_key.rancher.public_key_openssh
}
