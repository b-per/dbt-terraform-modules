
terraform {
  required_version = ">= 1.3"

  required_providers {
    dbtcloud = {
      source  = "dbt-labs/dbtcloud"
      version = ">= 0.3.0"
    }
  }
}


// create a global connection that we will link to environments
// this is an example with Snowflake but for other warehouses please look at the resource docs
resource "dbtcloud_global_connection" "dbt_connection" {
  name = "Snowflake DW - ${var.dbt_project_name}"
  snowflake = {
    account                   = var.snowflake_account
    database                  = var.snowflake_databases["DEV"].name
    warehouse                 = var.snowflake_warehouses["DEV"].name
    role                      = var.snowflake_roles["DEV"].name
  }
}

// we use user/password but there are other options on the resource docs
resource "dbtcloud_snowflake_credential" "creds" {
  for_each    = var.envs_except_dev
  project_id  = var.dbt_project_id
  auth_type   = "password"
  num_threads = 16
  schema      = "ANALYTICS"
  warehouse   = var.snowflake_warehouses[each.key].name
  database    = var.snowflake_databases[each.key].name
  role        = var.snowflake_roles[each.key].name
  user        = var.snowflake_service_users[each.key].name
  // note, this is a simple example to get Terraform and dbt Cloud working, but do not store passwords in the config for a real productive use case
  // there are different strategies available to protect sensitive input: https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables
  password    = var.snowflake_service_users[each.key].password
}

resource "dbtcloud_snowflake_credential" "creds_ci" {
  for_each    = var.defer_from_to
  project_id  = var.dbt_project_id
  auth_type   = "password"
  num_threads = 16
  schema      = "CI"
  warehouse   = var.snowflake_warehouses[each.key].name
  database    = var.snowflake_databases[each.key].name
  role        = var.snowflake_roles[each.key].name
  user        = var.snowflake_service_users[each.value["defer_to_env_name"]].name
  // note, this is a simple example to get Terraform and dbt Cloud working, but do not store passwords in the config for a real productive use case
  // there are different strategies available to protect sensitive input: https://developer.hashicorp.com/terraform/tutorials/configuration-language/sensitive-variables
  password    = var.snowflake_service_users[each.value["defer_to_env_name"]].password
}