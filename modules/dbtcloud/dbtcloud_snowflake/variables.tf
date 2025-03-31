variable "dbt_project_id" {
    description = "The Project ID for the dbt Cloud Project"
    type = number
}

variable "dbt_project_name" {
    description = "The Project ID for the dbt Cloud Project"
    type = string
}

variable "snowflake_account" {
    description = "The Snowflake Account ID"
    type = string
}

variable "snowflake_databases" {
    description = "The Snowflake Databases that were created"
    type = map(object({
      name = string
    }))
}

variable "snowflake_roles" {
    description = "The Snowflake Roles that were created"
    type = map(object({
      name = string
    }))
}

variable "snowflake_warehouses" {
    description = "The Snowflake Warehouses that were created"
    type = map(object({
      name = string
    }))
}

variable "snowflake_service_users" {
    description = "The Snowflake Service Users that were created"
    type = map(object({
      name = string
      password = string
    }))
}

variable "envs_except_dev" {
  description = "The deployment environments. A subset of `database_envs`."
  type = map(any)
}

variable "defer_from_to" {
  description = "Map of all the environments that can defer to another one in CI. Key and Value are the environment names"
  type = map(object({
    defer_to_env_name = string
  }))
}