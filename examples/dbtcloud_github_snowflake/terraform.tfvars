# Snowflake config
snowflake_account = "your_snowflake_account"
raw_database      = "RAW"

# dbt config
dbt_account_id         = your_account_id
dbt_host_url           = "https://emea.dbt.com/api"
dbt_version            = "1.6.0-latest"
github_installation_id = your_github_installation_id

# github config
# you can use this template or point to your own
cruft_template_url = "https://github.com/b-per/dbt-project-template.git"

# project config
project_name = "My Awesome Project"

# you can list more than the 2 Databases if you want to use more environments
# the git branch is used for setting the branch of the CI environment in dbt Cloud
database_envs = {
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

# in the default example, we provide the new developer roles to the users listed in developers
developers = ["USER1", "USER2"]
