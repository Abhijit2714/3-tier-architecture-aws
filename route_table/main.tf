resource "aws_route_table" "example" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
    Name = "rt"
  }
}  

output "route_table_id" {
  value = aws_route_table.example.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = var.subnet_id_public_2
  route_table_id = aws_route_table.example.id
}

resource "aws_default_route_table" "example" {
  default_route_table_id = var.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

 

  tags = {
    Name = "rtfornat"
  }
}