terraform {
  required_version = ">= 1.3"

  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = ">= 0.2.10"
    }
  }
}

// create a project
resource "dbtcloud_project" "dbt_project" {
  name = var.dbt_project_name
}

resource "dbtcloud_project_connection" "dbt_project_connection" {
  project_id    = dbtcloud_project.dbt_project.id
  connection_id = var.dbt_connection.connection_id
}

resource "dbtcloud_repository" "dbt_repository" {
  project_id             = dbtcloud_project.dbt_project.id
  remote_url             = var.github_repo_remote_url
  github_installation_id = var.github_installation_id
  git_clone_strategy     = "github_app"
}

resource "dbtcloud_project_repository" "dbt_project_repository" {
  project_id    = dbtcloud_project.dbt_project.id
  repository_id = dbtcloud_repository.dbt_repository.repository_id
}

// create different environments
resource "dbtcloud_environment" "envs" {
  for_each      = var.database_envs
  dbt_version   = var.dbt_version
  name          = each.key
  project_id    = dbtcloud_project.dbt_project.id
  type          = each.key == "DEV" ? "development"  : "deployment"
  deployment_type = each.key == "PROD" ? "production"  : null
  credential_id = each.key == "DEV" ? null : var.dbt_creds[each.key].credential_id
  custom_branch = each.value["git_branch"]
  use_custom_branch = each.value["git_branch"] == null ? false : true
}

resource "dbtcloud_environment" "envs_ci" {
  for_each      = var.defer_from_to
  dbt_version   = var.dbt_version
  name          = "CI - ${each.key}"
  project_id    = dbtcloud_project.dbt_project.id
  type          = "deployment"
  credential_id = var.dbt_creds_ci[each.key].credential_id
  custom_branch = var.database_envs[each.value["defer_to_env_name"]].git_branch
  use_custom_branch = var.database_envs[each.value["defer_to_env_name"]].git_branch == null ? false : true
}


resource "dbtcloud_job" "ci" {
  for_each = var.defer_from_to
  environment_id = dbtcloud_environment.envs_ci[each.key].environment_id
  execute_steps = [
    "dbt build -s state:modified+ --fail-fast"
  ]
  generate_docs        = false
  run_generate_sources = false
  is_active            = true
  name                 = "CI - ${each.key}"
  num_threads          = 16
  project_id           = dbtcloud_project.dbt_project.id
  # target_name          = "default"
  triggers = {
    "custom_branch_only" : true,
    "github_webhook" : true,
    "git_provider_webhook" : true,
    "schedule" : false
  }
  deferring_environment_id = dbtcloud_environment.envs[each.value["defer_to_env_name"]].environment_id
  # this is the default that gets set up when modifying jobs in the UI
  schedule_days = [0, 1, 2, 3, 4, 5, 6]
  schedule_type = "days_of_week"
}

resource "dbtcloud_job" "daily_prod" {
  environment_id = dbtcloud_environment.envs["PROD"].environment_id
  execute_steps = [
    "dbt build"
  ]
  generate_docs        = true
  run_generate_sources = true
  is_active            = true
  name                 = "PROD - Daily - run"
  num_threads          = 16
  project_id           = dbtcloud_project.dbt_project.id
  # target_name          = "default"
  triggers = {
    "custom_branch_only" : false,
    "github_webhook" : false,
    "git_provider_webhook" : false,
    "schedule" : true
  }
  # this is the default that gets set up when modifying jobs in the UI
  schedule_days = [0, 1, 2, 3, 4, 5, 6]
  schedule_type = "days_of_week"
  schedule_hours = [0]
}


locals {
  map_env_var_project = {"project" : "DEV"}
  map_env_var_envs = {for env_name, vals in dbtcloud_environment.envs : vals.name => vals.name}
  map_env_var_ci_envs = {for env_name, vals in dbtcloud_environment.envs_ci : vals.name => "CI"}

}

resource "dbtcloud_environment_variable" "my_env_var" {
  name       = "DBT_ENV_NAME"
  project_id = dbtcloud_project.dbt_project.id
  environment_values = merge(local.map_env_var_project, local.map_env_var_envs, local.map_env_var_ci_envs)
}