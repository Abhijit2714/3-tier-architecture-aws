resource "aws_nat_gateway" "nat_gateway_1" {
  allocation_id = var.allocation_id_nat_1
  subnet_id     = var.subnet_id_public_2
  # connectivity_type = "private"
  tags = {
    Name = "gw NAT"
  }
  depends_on = [ var.internet_geteway_id ]
}