resource "aws_key_pair" "bastion_key" {
  key_name   = "bastion-key1"
  public_key = file("${path.module}/id_rsa.pub")
}

resource "aws_internet_gateway" "gw" {
  vpc_id = var.vpc_id

  tags = {
    Name = "main"
  }
}

# output "internet_geteway_id" {
#   value = aws_internet_gateway.gw.id
# }

provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20230919"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  #   owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id_public_2
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = "bastion-key1"
  associate_public_ip_address = true

  tags = {
    Name = "Bastion-Host"
  }
 
  depends_on = [aws_internet_gateway.gw]
  user_data  = file("${path.module}/script.sh")  
}


resource "aws_instance" "public-2" {
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t2.micro"
  subnet_id                   = var.subnet_id_public_1
  vpc_security_group_ids      = [var.security_group_id]
  key_name                    = "bastion-key1"
  associate_public_ip_address = true
  user_data = file("${path.module}/script.sh")

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("${path.module}/id_rsa")
    host = "${self.public_ip}"
  }

  tags = {
    Name = "Ec2_Instance_4"
  }


}