module "network" {
  source = "./network"

  project_name = var.project_name
}

module "cognito" {
  source = "./cognito"

  project_name         = var.project_name
  google_client_id     = var.google_client_id
  google_client_secret = var.google_client_secret
  callback_urls        = var.callback_urls
  logout_urls          = var.logout_urls
}

module "erc" {
  source = "./erc"

  project_name = var.project_name
}

module "database" {
  source = "./database"

  project_name       = var.project_name
  db_name            = var.db_name
  db_master_username = var.db_master_username
  db_master_password = var.db_master_password
  sg_ids             = [module.network.aurora_sg_id]
  db_subnet_ids      = module.network.backend_subnet_ids
}

module "fargate" {
  source = "./fargate"

  project_name  = var.project_name
  lb_sg_id      = module.network.alb_sg_id
  lb_subnets_id = [module.network.backend_subnet_id, module.network.frontend_subnet_id]
}
