locals {

    project_name = var.project_name
    project_slug = trimspace(lower(replace(local.project_name, "/[^a-zA-Z0-9]+/", "_")))
    envs_except_dev = { for env_name, vals in var.database_envs : env_name => vals if env_name != "DEV" }
    defer_from_to = { for env_name, vals in var.database_envs : env_name => vals if vals["defer_to_env_name"] != null }

}
