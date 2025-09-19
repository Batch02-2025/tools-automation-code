terraform {
  backend "s3" {
    bucket = "batch-02-tools"
    key    = "tools/terraform.tfstate"
    region = "ap-south-1"
  }
}
