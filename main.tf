provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  env    = var.env
}

module "ec2" {
  source        = "./modules/ec2"
  vpc_id        = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  env           = var.env
}

module "alb" {
  source        = "./modules/alb"
  vpc_id        = module.vpc.vpc_id
  public_subnets = module.vpc.public_subnets
  target_group_instances = module.ec2.instance_ids
  env           = var.env
}

module "s3" {
  source = "./modules/s3"
  env    = var.env
}
