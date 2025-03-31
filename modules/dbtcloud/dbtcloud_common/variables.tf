variable "dbt_project_name" {
    description = "The project name in dbt Cloud"
    type = string
}

variable "github_installation_id" {
    description = "The project name in dbt Cloud"
    type = string
    # TODO: if it is NULL then we use the deploy_key approach
    # default = null
}

variable "dbt_connection" {
    description = "The connection to the DW"
    type = map(any)
}

variable "github_repo_remote_url" {
    description = "The remote URL for the GitHub repository"
    type = string
    default = null
}

variable "dbt_version" {
    description = "The dbt version"
    type = string
}

variable "database_envs" {
  description = "The different environments required (i.e. DEV, PROD etc...) and their properties"
  type = map(object({
    wh_size           = string
    defer_to_env_name = string
    git_branch        = string
  }))
}

variable "dbt_creds" {
  description = "A map of environment name to dbt cloud credential ID"
  type = map(object({
    credential_id = integer
  }))
}

variable "dbt_creds_ci" {
  description = "A map of environment name to dbt cloud credential ID for CI"
  type = map(object({
    credential_id = integer
  }))
}

variable "defer_from_to" {
  description = "Map of all the environments that can defer to another one in CI. Key and Value are the environment names"
  type = map(object({
    defer_to_env_name = string
  }))
}