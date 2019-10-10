terraform {
  backend "s3" {
    bucket = "siliconhills-terraform"
    key    = "orch.siliconhills.co/nodes"
    region = "us-west-2"
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "siliconhills-terraform"
    key    = "orch.siliconhills.co/nodes"
    region = "us-west-2"
  }
}
provider "aws" {
  region = "${var.region}"
  shared_credentials_file = "~/.aws/credentials"
}
variable "aws_access_key" {
  type = "string"
}
variable "aws_secret_key" {
  type = "string"
}
variable "dedicated_desired_capacity" {
  type    = "string"
  default = "1"
}
variable "spot_desired_capacity" {
  type    = "string"
  default = "2"
}
variable "command" {
  type    = "string"
}
variable "region" {
  type    = "string"
  default = "us-west-2"
}
variable "name" {
  type    = "string"
  default = "node"
}
variable "volume_size" {
  type    = "string"
  default = "40"
}
variable "dedicated_instance_type" {
  type    = "string"
  default = "t2.medium"
}
variable "spot_instance_type" {
  type    = "string"
  default = "t2.large"
}
variable "docker_version" {
  type    = "string"
  default = "18.09.4-ce"
}
variable "ami" {
  type    = "string"
  default = "ami-e59ae09d"
}
