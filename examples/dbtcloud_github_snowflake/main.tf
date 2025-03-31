
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
      version = ">= 0.3.0"
    }
  }
}

provider "snowflake" {
  account  = var.snowflake_account
  username = var.snowflake_username
  password = var.snowflake_password
}

provider "dbtcloud" {
  account_id = var.dbt_account_id
  token      = var.dbt_token
  host_url   = var.dbt_host_url
}

provider "github" {
  token = var.github_token
}


# to create Snowflake users/databases/roles/warehouses
# it is recommended to pin the module to a specific version to avoid breaking changes
module "dbtcloud_github_snowflake" {
  source = "github.com/b-per/dbt-terraform-modules?ref=v0.1.4//modules/combined/dbtcloud_github_snowflake"


  snowflake_account      = var.snowflake_account
  github_token           = var.github_token
  raw_database           = var.raw_database
  cruft_template_url     = var.cruft_template_url
  database_envs          = var.database_envs
  dbt_account_id         = var.dbt_account_id
  dbt_token              = var.dbt_token
  dbt_host_url           = var.dbt_host_url
  github_installation_id = var.github_installation_id
  dbt_version            = var.dbt_version
  project_name           = var.project_name
  developers             = var.developers

}

