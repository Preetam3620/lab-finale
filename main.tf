provider "aws" {
  region = var.region
}

data "aws_caller_identity" "current" {}


module "vpc" {
  source = "./modules/vpc"
  region = var.region
  vpc_cidr = var.vpc_cidr
}

module "security" {
  source  = "./modules/security"
  vpc_id  = module.vpc.vpc_id
  alb_arn = module.alb.alb_arn
}

module "alb" {
  source            = "./modules/alb"
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnets
  security_group_id = module.security.alb_security_group_id
}

module "ecs" {
  source                = "./modules/ecs"
  vpc_id                = module.vpc.vpc_id
  private_subnet_ids    = module.vpc.private_subnets
  alb_target_group_arn  = module.alb.target_group_arn
  ecs_security_group_id = module.security.ecs_security_group_id
  region = var.region
}

module "database" {
  source             = "./modules/database"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnets
}

module "monitoring" {
  source = "./modules/monitoring"
  ecs_cluster_name = var.ecs_cluster_name
  alb_arn_suffix = var.alb_arn_suffix
  region = var.region
}

module "api_gateway" {
  source = "./modules/api_gateway"
}

module "s3" {
  source = "./modules/s3"
}

module "cognito" {
  source = "./modules/cognito"
}

module "secrets_manager" {
  source = "./modules/secrets_manager"
}

output "alb_arn" {
  value = module.alb.alb_arn
}

output "target_group_arn" {
  value = module.alb.target_group_arn
}
output "api_endpoint" {
  value = module.api_gateway.api_endpoint
}
output "user_pool_id" {
  value = module.cognito.user_pool_id
}
output "user_pool_client_id" {
  value = module.cognito.user_pool_client_id
}
output "dynamodb_table_name" {
  value = module.database.dynamodb_table_name
}
output "log_group_name" {
  value = module.monitoring.log_group_name
}
output "bucket_name" {
  value = module.s3.bucket_name
}
output "waf_acl_id" {
  value = module.security.waf_acl_id
}
output "alb_security_group_id" {
  value = module.security.alb_security_group_id
}
output "ecs_security_group_id" {
  value = module.security.ecs_security_group_id
}
output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnets" {
  value = module.vpc.public_subnets
}
output "private_subnets" {
  value = module.vpc.private_subnets
}