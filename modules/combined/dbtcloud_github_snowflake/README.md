<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_dbtcloud"></a> [dbtcloud](#requirement\_dbtcloud) | >= 0.3.0 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | ~> 0.71 |

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_dbtcloud_common"></a> [dbtcloud\_common](#module\_dbtcloud\_common) | ../../dbtcloud/dbtcloud_common | n/a |
| <a name="module_dbtcloud_snowflake"></a> [dbtcloud\_snowflake](#module\_dbtcloud\_snowflake) | ../../dbtcloud/dbtcloud_snowflake | n/a |
| <a name="module_github"></a> [github](#module\_github) | ../../github | n/a |
| <a name="module_snowflake"></a> [snowflake](#module\_snowflake) | ../../snowflake | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cruft_template_url"></a> [cruft\_template\_url](#input\_cruft\_template\_url) | n/a | `string` | n/a | yes |
| <a name="input_database_envs"></a> [database\_envs](#input\_database\_envs) | n/a | <pre>map(object({<br>    wh_size           = string<br>    defer_to_env_name = string<br>    git_branch        = string<br>  }))</pre> | <pre>{<br>  "DEV": {<br>    "defer_to_env_name": "PROD",<br>    "git_branch": null,<br>    "wh_size": "X-SMALL"<br>  },<br>  "PROD": {<br>    "defer_to_env_name": null,<br>    "git_branch": "main",<br>    "wh_size": "X-SMALL"<br>  }<br>}</pre> | no |
| <a name="input_dbt_account_id"></a> [dbt\_account\_id](#input\_dbt\_account\_id) | n/a | `number` | n/a | yes |
| <a name="input_dbt_host_url"></a> [dbt\_host\_url](#input\_dbt\_host\_url) | n/a | `string` | n/a | yes |
| <a name="input_dbt_token"></a> [dbt\_token](#input\_dbt\_token) | n/a | `string` | n/a | yes |
| <a name="input_dbt_version"></a> [dbt\_version](#input\_dbt\_version) | n/a | `string` | n/a | yes |
| <a name="input_developers"></a> [developers](#input\_developers) | n/a | `set(string)` | n/a | yes |
| <a name="input_github_installation_id"></a> [github\_installation\_id](#input\_github\_installation\_id) | n/a | `number` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | n/a | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_raw_database"></a> [raw\_database](#input\_raw\_database) | n/a | `string` | `"RAW"` | no |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | n/a | `string` | n/a | yes |
| <a name="input_snowflake_developers_role"></a> [snowflake\_developers\_role](#input\_snowflake\_developers\_role) | n/a | `string` | `"tf_dbt_developers"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->