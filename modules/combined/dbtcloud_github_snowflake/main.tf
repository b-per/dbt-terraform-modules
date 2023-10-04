
terraform {
  required_version = ">= 1.3"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.71"
    }
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = ">= 0.2.10"
    }
  }
}

# to create a GitHub repo based on a Cruft Template
module "github" {
  source = "../../github"

  github_token       = var.github_token
  project_name       = var.project_name
  project_slug       = local.project_slug
  cruft_template_url = var.cruft_template_url

}


# to create Snowflake users/databases/roles/warehouses
module "snowflake" {
  source = "../../snowflake"

  project_slug    = local.project_slug
  database_envs   = var.database_envs
  defer_from_to   = local.defer_from_to
  envs_except_dev = local.envs_except_dev
  raw_database    = var.raw_database
  developers      = var.developers

}

# to create the config for dbt Cloud that doesn't depend on the adapter
# project, envs, jobs, etc...
module "dbtcloud_common" {
  source         = "../../dbtcloud/dbtcloud_common"

  dbt_project_name       = var.project_name
  database_envs          = var.database_envs
  github_installation_id = var.github_installation_id
  github_repo_remote_url = module.github.github_repo_remote_url
  dbt_version            = var.dbt_version
  defer_from_to          = local.defer_from_to

  # creds from another module
  dbt_connection = module.dbtcloud_snowflake.dbt_connection
  dbt_creds      = module.dbtcloud_snowflake.dbt_creds
  dbt_creds_ci   = module.dbtcloud_snowflake.dbt_creds_ci
}


# to create the dbt Cloud config specific to Snowflake
module "dbtcloud_snowflake" {
  source = "../../dbtcloud/dbtcloud_snowflake"

  # global config
  snowflake_account = var.snowflake_account

  # project variables
  dbt_project_name = var.project_name
  envs_except_dev  = local.envs_except_dev
  defer_from_to    = local.defer_from_to

  #from the other dbt module
  dbt_project_id = module.dbtcloud_common.dbt_project_id

  # snowflake variables
  snowflake_service_users      = module.snowflake.snowflake_users
  snowflake_warehouses = module.snowflake.snowflake_warehouses
  snowflake_databases  = module.snowflake.snowflake_databases
  snowflake_roles      = module.snowflake.snowflake_roles
}