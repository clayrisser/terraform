terraform {
  backend "s3" {
    bucket = "dev.siliconhills.terraform"
    key    = "kube.siliconhills.dev/kube"
    region = "us-west-2"
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "dev.siliconhills.terraform"
    key    = "kube.siliconhills.dev/kube"
    region = "us-west-2"
  }
}
provider "aws" {
  region = var.region
  shared_credentials_file = "~/.aws/credentials"
}
variable "region" {
  type    = string
  default = "us-west-2"
}
variable "name" {
  type    = string
  default = "kube"
}
variable "domain" {
  type    = string
  default = "siliconhills.dev"
}
variable "volume_size" {
  type    = string
  default = "40"
}
variable "instance_type" {
  type    = string
  default = "t2.medium"
}
variable "rancher_version" {
  type    = string
  default = "v2.4.2"
}
variable "docker_version" {
  type    = string
  default = "19.03.8-ce"
}
variable "ami" {
  type    = string
  default = "ami-0d5f95b9a27dfef6f"
}
