resource "aws_s3_bucket" "s3-bucket" {
  bucket = "statefile-bucket-22222714"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}