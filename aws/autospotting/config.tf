terraform {
  backend "s3" {
    bucket = "siliconhills-terraform"
    key    = "orch.siliconhills.dev/autospotting"
    region = "us-west-2"
  }
}
data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket = "siliconhills-terraform"
    key    = "orch.siliconhills.dev/autospotting"
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
