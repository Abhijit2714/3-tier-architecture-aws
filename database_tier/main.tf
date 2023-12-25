resource "aws_db_subnet_group" "subnet-group" {
  name       = "main"
  subnet_ids = [var.subnet_id_public_2, var.subnet_id_private]
  
  tags = {
    Name = "My DB subnet group"
  }
}

output "subnet_group_name" {
  value = aws_db_subnet_group.subnet-group.name
}

resource "aws_db_instance" "database_tier" {
  allocated_storage         = 20
  storage_type              = "gp2"
  engine                    = "mysql"
  engine_version            = "5.7"
  instance_class            = "db.t2.micro"
  db_name                   = "mysqldatabase"
  username                  = "admin"
  password                  = "adminadmin"
  parameter_group_name      = "default.mysql5.7"
  availability_zone         = "us-east-1a"
  vpc_security_group_ids    = [var.security_group_id]
  db_subnet_group_name      = aws_db_subnet_group.subnet-group.name
  final_snapshot_identifier = "db-snpshot"

}