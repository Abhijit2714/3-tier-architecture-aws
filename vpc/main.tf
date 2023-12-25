resource "aws_vpc" "main" {
  cidr_block = var.cidr_block
}

output "id" {
    value = aws_vpc.main.id 
}

output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}

output "cidr_block" {
  value = aws_vpc.main.cidr_block
}



