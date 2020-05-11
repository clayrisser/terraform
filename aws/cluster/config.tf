terraform {
  backend "s3" {
    bucket = "dev.siliconhills.terraform"
    key    = "kube.siliconhills.dev/nodes"
    region = "us-west-2"
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "dev.siliconhills.terraform"
    key    = "kube.siliconhills.dev/nodes"
    region = "us-west-2"
  }
}
provider "aws" {
  region = var.region
  shared_credentials_file = "~/.aws/credentials"
}
variable "aws_access_key" {
  type = string
}
variable "aws_secret_key" {
  type = string
}
variable "dedicated_desired_capacity" {
  type    = string
  default = "1"
}
variable "spot_desired_capacity" {
  type    = string
  default = "4"
}
variable "command" {
  type = string
}
variable "cluster_id" {
  type = string
}
variable "region" {
  type    = string
  default = "us-west-2"
}
variable "name" {
  type    = string
  default = "nodes"
}
variable "domain" {
  type    = string
  default = "siliconhills.dev"
}
variable "docker_version" {
  type    = string
  default = "19.03.8-ce"
}
variable "ami" {
  type    = string
  default = "ami-0d5f95b9a27dfef6f"
}
variable "availability_zones" {
  type  = list(string)
  default = ["a"]
}
