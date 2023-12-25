output "ami_id" {
  value = data.aws_ami.ubuntu
}

output "instance" {
  value = aws_instance.web.id
}

output "instance_4" {
  value = aws_instance.public-2.id
}

output "internet_geteway_id" {
  value = aws_internet_gateway.gw.id
}