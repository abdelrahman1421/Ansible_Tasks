module "vpc" {
  source   = "./vpc"
  vpc_cidr = var.vpc_cidr

}


module "network" {
  source               = "./network"
  public_subnet_a_cidr = var.public_subnet_a_cidr
  vpc_id               = module.vpc.vpc_id
  depends_on           = [module.vpc]
}



module "securitygroups" {
  source     = "./securitygroups"
  vpc_id     = module.vpc.vpc_id
  depends_on = [module.vpc]
}

module "ec2" {
  source                       = "./ec2"
  instance_ami_a               = var.instance_ami_a
  instance_ami_b               = var.instance_ami_b
  instance_ami_c               = var.instance_ami_c
  terraform_public_subnet_a_id = module.network.terraform_public_subnet_a_id
  instance_type                = var.instance_type
  ssh_key                      = var.ssh_key
  vpc_security_group_ids       = module.securitygroups.security_group_id
  depends_on                   = [module.network]
}

