resource "aws_dynamodb_table" "state_lock_table" {
  name           = "TerraformStateLock"
  billing_mode   = "PAY_PER_REQUEST"  
  hash_key       = "LockID"          
  read_capacity  = 0                  
  write_capacity = 0                  

  attribute {
    name = "LockID"
    type = "S"  # String type for LockID
  }

  tags = {
    Name        = "TerraformStateLockTable"
    Environment = "Sandbox"
  }
}