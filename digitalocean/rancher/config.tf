terraform {
  backend "s3" {
    access_key                  = "redacted"
    bucket                      = "co.siliconhills.terraform"
    endpoint                    = "https://sfo2.digitaloceanspaces.com"
    key                         = "kube.siliconhills.co/kube"
    region                      = "us-east-1"
    secret_key                  = var.secret
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    access_key                  = "redacted"
    bucket                      = "co.siliconhills.terraform"
    endpoint                    = "https://sfo2.digitaloceanspaces.com"
    key                         = "kube.siliconhills.co/kube"
    region                      = "us-east-1"
    secret_key                  = var.secret
    skip_credentials_validation = true
    skip_get_ec2_platforms      = true
    skip_metadata_api_check     = true
    skip_requesting_account_id  = true
  }
}
provider "digitalocean" {
  token = var.token
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
  default = "siliconhills.co"
}
variable "rancher_version" {
  type    = string
  default = "v2.4.4"
}
variable "docker_version" {
  type    = string
  default = "19.03.8-ce"
}
variable "token" {
  type = string
}
variable "secret" {
  type = string
}
