module "vpc" {
  source     = "../vpc"
  cidr_block = var.cidr_block
}

module "subnet" {
  source = "../subnets"
  vpc_id = module.vpc.id
}

module "route_table" {
  source                 = "../route_table"
  gateway_id             = module.ec2_instance.internet_geteway_id
  vpc_id                 = module.vpc.id
  default_route_table_id = module.vpc.default_route_table_id
  subnet_id_public_2     = module.subnet.subnet_id_public_2
}

module "ec2_instance" {
  source             = "../ec2-instance"
  vpc_id             = module.vpc.id
  subnet_id_public_2 = module.subnet.subnet_id_public_2
  subnet_id_public_1 = module.subnet.subnet_id_public_1
  security_group_id  = module.security_group.security_group_ids
}

# module "ec2_instance_4" {
#   source = "../ec2_instance_4"
#   subnet_id_public_1 = module.subnet.subnet_id_public_1
#   security_group_id = module.security_group.security_group_ids  
# }

# module "ec2_instance_2" {
#   source = "../ec2_instance_2"
#   subnet_id_private_1  = module.subnet.subnet_id_private_1
#   security_group_id = module.security_group.security_group_ids
# }

module "ec2_instance_1" {
  source            = "../ec2_instance_1"
  subnet_id_private = module.subnet.subnet_id_private
  security_group_id = module.security_group.security_group_ids
}

# module "elb" {
#   source     = "../elastic_ip"
#   instance = module.ec2_instance.instance
# }

module "elb-1" {
  source = "../eip_for_nat_1"
}

module "nat_gateway_1" {
  source              = "../nat_gateway_1"
  allocation_id_nat_1 = module.elb-1.allocation_id_nat_1
  subnet_id_public_2  = module.subnet.subnet_id_public_2
  internet_geteway_id = module.ec2_instance.internet_geteway_id
}

module "application_load_balance" {
  source             = "../application_load_balancer"
  vpc_id             = module.vpc.id
  instance           = module.ec2_instance.instance
  instance_4         = module.ec2_instance.instance_4
  security_group_id  = module.security_group.security_group_ids
  subnet_id_public_2 = module.subnet.subnet_id_public_2
  subnet_id_public_1 = module.subnet.subnet_id_public_1

}

module "security_group" {
  source = "../security_group"
  vpc_id = module.vpc.id
}


module "database_instance" {
  source             = "../database_tier"
  security_group_id  = module.security_group.security_group_ids
  subnet_id_private  = module.subnet.subnet_id_private
  subnet_id_public_2 = module.subnet.subnet_id_public_2
}



