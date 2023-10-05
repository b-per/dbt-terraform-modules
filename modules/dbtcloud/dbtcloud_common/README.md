<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_dbtcloud"></a> [dbtcloud](#requirement\_dbtcloud) | >= 0.2.10 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_dbtcloud"></a> [dbtcloud](#provider\_dbtcloud) | >= 0.2.10 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [dbtcloud_environment.envs](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/environment) | resource |
| [dbtcloud_environment.envs_ci](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/environment) | resource |
| [dbtcloud_environment_variable.my_env_var](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/environment_variable) | resource |
| [dbtcloud_job.ci](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/job) | resource |
| [dbtcloud_job.daily_prod](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/job) | resource |
| [dbtcloud_project.dbt_project](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/project) | resource |
| [dbtcloud_project_connection.dbt_project_connection](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/project_connection) | resource |
| [dbtcloud_project_repository.dbt_project_repository](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/project_repository) | resource |
| [dbtcloud_repository.dbt_repository](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_envs"></a> [database\_envs](#input\_database\_envs) | n/a | <pre>map(object({<br>    wh_size           = string<br>    defer_to_env_name = string<br>    git_branch        = string<br>  }))</pre> | n/a | yes |
| <a name="input_dbt_connection"></a> [dbt\_connection](#input\_dbt\_connection) | The connection to the DW | `map(any)` | n/a | yes |
| <a name="input_dbt_creds"></a> [dbt\_creds](#input\_dbt\_creds) | n/a | `map(any)` | n/a | yes |
| <a name="input_dbt_creds_ci"></a> [dbt\_creds\_ci](#input\_dbt\_creds\_ci) | n/a | `map(any)` | n/a | yes |
| <a name="input_dbt_project_name"></a> [dbt\_project\_name](#input\_dbt\_project\_name) | The project name in dbt Cloud | `string` | n/a | yes |
| <a name="input_dbt_version"></a> [dbt\_version](#input\_dbt\_version) | The dbt version | `string` | n/a | yes |
| <a name="input_defer_from_to"></a> [defer\_from\_to](#input\_defer\_from\_to) | n/a | `map(any)` | n/a | yes |
| <a name="input_github_installation_id"></a> [github\_installation\_id](#input\_github\_installation\_id) | The project name in dbt Cloud | `string` | n/a | yes |
| <a name="input_github_repo_remote_url"></a> [github\_repo\_remote\_url](#input\_github\_repo\_remote\_url) | The remote URL for the GitHub repository | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbt_project_id"></a> [dbt\_project\_id](#output\_dbt\_project\_id) | n/a |
<!-- END_TF_DOCS -->