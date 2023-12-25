terraform {
  backend "s3" {
    bucket         = "statefile-bucket-22222714"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "TerraformStateLock"
  }
}