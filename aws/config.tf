terraform {
  backend "s3" {
    bucket = "siliconhills-terraform"
    key    = "orch.siliconhills.co/orch"
    region = "us-west-2"
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "siliconhills-terraform"
    key    = "${var.name}.${var.domain}/orch"
    region = "${var.region}"
  }
}
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
}
variable "region" {
  type    = "string"
  default = "us-west-2"
}
variable "name" {
  type    = "string"
  default = "orch"
}
variable "domain" {
  type    = "string"
  default = "siliconhills.co"
}
variable "volume_size" {
  type    = "string"
  default = "40"
}
variable "instance_type" {
  type    = "string"
  default = "t2.medium"
}
variable "rancher_version" {
  type    = "string"
  default = "latest"
}
variable "docker_version" {
  type    = "string"
  default = "18.09.4-ce"
}
