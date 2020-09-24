terraform {
  backend "s3" {
    bucket                      = "dev.siliconhills"
    endpoint                    = "https://sfo2.digitaloceanspaces.com"
    key                         = "terraform/kube.siliconhills.dev/kube"
    region                      = "us-east-1"
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}
provider "aws" {
  region = "us-east-1"
}
provider "digitalocean" {
  token = var.digitalocean_token
}
provider "cloudflare" {
  account_id = var.cloudflare_account_id
  api_key    = var.cloudflare_api_key
  email      = var.cloudflare_email
  version    = "~> 2.0"
}
variable "region" {
  type    = string
  default = "sfo2"
}
variable "name" {
  type    = string
  default = "kube"
}
variable "domain" {
  type    = string
  default = "siliconhills.dev"
}
variable "rancher_version" {
  type    = string
  default = "v2.4.5"
}
variable "docker_version" {
  type    = string
  default = "19.03.12-ce"
}
variable "cloudflare_email" {
  type    = string
  default = "jam@siliconhills.dev"
}
variable "cloudflare_zone_id" {
  type    = string
  default = "330a7f46b4c2ca1a64261d9231c0da48"
}
variable "cloudflare_account_id" {
  type    = string
  default = "efeda46708f446060c9d22f956f7d76b"
}
variable "digitalocean_token" {
  type = string
}
variable "digitalocean_secret_key" {
  type = string
}
variable "digitalocean_access_key" {
  type = string
}
variable "cloudflare_api_key" {
  type = string
}
