module "network" {
  source = "./modules/network"

  cluster_name = var.cluster_name
  region = var.region
}

module "rds" {
  source = "./modules/rds"

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
  eks_subnet_public_1b = module.network.eks_subnet_public_1b
  eks_subnet_public_1a = module.network.eks_subnet_public_1a
  vpc_id = module.network.vpc_id

  db_cluster_name = "DB_CLUSTER_NAME_HERE"
  db_name = "DB_NAME_HERE"
  db_username = "DB_USERNAME_HERE"
  db_password = "DB_PASSWORD_HERE"
}

module "master" {
  source = "./modules/master"

  cluster_name = var.cluster_name
  kubernetes_version = var.kubernetes_version

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b
}

module "node" {
  source = "./modules/node"

  cluster_name = module.master.cluster_name

  private_subnet_1a = module.network.private_subnet_1a
  private_subnet_1b = module.network.private_subnet_1b

  desired_size = var.desired_size
  min_size = var.min_size
  max_size = var.max_size

}

module "lambda" {
  source = "./modules/lambda"

  lambda_name = var.lambda_name
}

module "kubernetes_nlb" {
  source = "./modules/kubernetes_nlb"

  cluster_name = module.master.cluster_name
  region = var.region
}

module "api_gateway" {
  source = "./modules/api-gateway"

  nlb_wait_trigger = module.kubernetes_nlb.wait_for_nlb_trigger
  nlb_arn = module.kubernetes_nlb.nlb_arn
  nlb_dns_name = module.kubernetes_nlb.nlb_dns_name
}