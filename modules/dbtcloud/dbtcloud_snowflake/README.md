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
| [dbtcloud_connection.dbt_connection](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/connection) | resource |
| [dbtcloud_snowflake_credential.creds](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/snowflake_credential) | resource |
| [dbtcloud_snowflake_credential.creds_ci](https://registry.terraform.io/providers/dbt-labs/dbtcloud/latest/docs/resources/snowflake_credential) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dbt_project_id"></a> [dbt\_project\_id](#input\_dbt\_project\_id) | The Project ID for the dbt Cloud Project | `number` | n/a | yes |
| <a name="input_dbt_project_name"></a> [dbt\_project\_name](#input\_dbt\_project\_name) | The Project ID for the dbt Cloud Project | `string` | n/a | yes |
| <a name="input_defer_from_to"></a> [defer\_from\_to](#input\_defer\_from\_to) | n/a | `map(any)` | n/a | yes |
| <a name="input_envs_except_dev"></a> [envs\_except\_dev](#input\_envs\_except\_dev) | n/a | `map(any)` | n/a | yes |
| <a name="input_snowflake_account"></a> [snowflake\_account](#input\_snowflake\_account) | The Snowflake Account ID | `string` | n/a | yes |
| <a name="input_snowflake_databases"></a> [snowflake\_databases](#input\_snowflake\_databases) | The Snowflake Databases that were created | <pre>map(object({<br>      name = string<br>    }))</pre> | n/a | yes |
| <a name="input_snowflake_roles"></a> [snowflake\_roles](#input\_snowflake\_roles) | The Snowflake Roles that were created | <pre>map(object({<br>      name = string<br>    }))</pre> | n/a | yes |
| <a name="input_snowflake_service_users"></a> [snowflake\_service\_users](#input\_snowflake\_service\_users) | The Snowflake Service Users that were created | <pre>map(object({<br>      name = string<br>      password = string<br>    }))</pre> | n/a | yes |
| <a name="input_snowflake_warehouses"></a> [snowflake\_warehouses](#input\_snowflake\_warehouses) | The Snowflake Warehouses that were created | <pre>map(object({<br>      name = string<br>    }))</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_dbt_connection"></a> [dbt\_connection](#output\_dbt\_connection) | n/a |
| <a name="output_dbt_creds"></a> [dbt\_creds](#output\_dbt\_creds) | n/a |
| <a name="output_dbt_creds_ci"></a> [dbt\_creds\_ci](#output\_dbt\_creds\_ci) | n/a |
<!-- END_TF_DOCS -->