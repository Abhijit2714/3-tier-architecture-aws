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
}

resource "aws_instance" "public-2" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  subnet_id     =  var.subnet_id_public_1
  vpc_security_group_ids = [var.security_group_id]
  key_name = "bastion-key1"
  associate_public_ip_address = true
  

  tags = {
    Name = "Ec2_Instance_4"
  }  
}

#####