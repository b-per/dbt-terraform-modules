variable "project_slug" {
    description = "Slug for the project with no special characters"
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

variable "defer_from_to" {
  description = "Map of all the environments that can defer to another one in CI. Key and Value are the environment names"
  type = map(object({
    defer_to_env_name = string
  }))
}

variable "raw_database" {
  description = "The name of the database where the raw data is stored"
  type = string
}

# Only the key matter, not the values
variable "envs_except_dev" {
  description = "The deployment environments. A subset of `database_envs`."
  type = map(any)
}

variable "developers" {
  description = "List of user IDs to assign the new developer role to"
  type = set(string)
}