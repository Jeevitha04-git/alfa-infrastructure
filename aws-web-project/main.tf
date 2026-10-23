module "vpc" {
  source            = "./modules/vpc"
  aws_region        = var.aws_region
  vpc_name          = var.vpc_name
  vpc_cidr          = var.vpc_cidr
  availability_zone = var.availability_zone

  subnet_name_public  = var.subnet_name_public
  subnet_name_private = var.subnet_name_private

  subnet_cidr_public  = var.subnet_cidr_public
  subnet_cidr_private = var.subnet_cidr_private

  ig_name               = var.ig_name
  route_table_public_rt = var.route_table_public_rt

  environment = var.environment
}

module "ec2_instance" {
  source = "./modules/ec2-instance"

  aws_region       = var.aws_region
  instance_name    = var.instance_name
  instancetype     = var.instancetype
  amiid            = var.amiid
  availabilityzone = var.availabilityzone
  key_name         = var.key_name
  environment      = var.environment
  subnet_public_id = module.vpc.public_subnet_id
}

module "security_group" {
  source = "./modules/security-group"

  vpc_id              = var.vpc_id
  security_group_name = var.security_group_name
  ssh_cidr            = var.ssh_cidr
  environment         = var.environment
}