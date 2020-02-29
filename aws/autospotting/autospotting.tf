module "autospotting" {
  autospotting_regions_enabled = var.region
  lambda_zipname               = "lambda.zip"
  source                       = "github.com/autospotting/terraform-aws-autospotting?ref=master"
}
