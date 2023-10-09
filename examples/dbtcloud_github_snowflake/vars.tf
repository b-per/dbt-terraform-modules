
variable "raw_database" {
  type    = string
  default = "RAW"
}

variable "cruft_template_url" {
  type = string
}

variable "database_envs" {
  type = map(object({
    wh_size           = string
    defer_to_env_name = string
    git_branch        = string
  }))
  default = {
    "DEV" = {
      wh_size           = "X-SMALL"
      defer_to_env_name = "PROD"
      git_branch        = null
    },
    "PROD" = {
      wh_size           = "X-SMALL"
      defer_to_env_name = null
      git_branch        = "main"
    }
  }
}


variable "dbt_account_id" {
  type = number
}

variable "dbt_host_url" {
  type = string
}

variable "github_installation_id" {
  type = number
}

variable "dbt_version" {
  type = string
}

variable "project_name" {
  type = string
}

variable "developers" {
  type = set(string)
}

variable "snowflake_account" {
  type = string
}

###
# SENSITIVE - set via env vars
####

variable "github_token" {
  type = string
}

variable "snowflake_username" {
  type = string
}

variable "snowflake_password" {
  type = string
}

variable "dbt_token" {
  type = string
}