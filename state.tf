terraform {
  backend "s3" {
    bucket = "batch02-tools"
    key    = "tools/terraform.tfstate"
    region = "us-east-1"
  }
}
