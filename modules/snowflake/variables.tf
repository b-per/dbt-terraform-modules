variable "project_slug" {
    description = "Slug for the project with no special characters"
    type = string
}

variable "database_envs" {
  type = map(object({
    wh_size           = string
    defer_to_env_name = string
    git_branch        = string
  }))
}

variable "defer_from_to" {
  type = map(any)
}

variable "raw_database" {
  type = string
}

variable "envs_except_dev" {
  type = map(any)
}

variable "developers" {
  type = set(string)
}