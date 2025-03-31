<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_snowflake"></a> [snowflake](#requirement\_snowflake) | ~> 0.71 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | n/a |
| <a name="provider_snowflake"></a> [snowflake](#provider\_snowflake) | ~> 0.71 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [random_password.password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [snowflake_database.dbt_databases](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/database) | resource |
| [snowflake_grant_privileges_to_role.database](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.deferral_database](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.deferral_database_future_schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.deferral_database_schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.deferral_existing_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.deferral_future_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.existing_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.future_schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.future_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.raw_current_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.raw_future_tables_views](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.raw_usage_all_schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.raw_usage_future_schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.schemas](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_grant_privileges_to_role.warehouse](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/grant_privileges_to_role) | resource |
| [snowflake_role.dbt_roles](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/role) | resource |
| [snowflake_role_grants.dbt_service_user_grants](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/role_grants) | resource |
| [snowflake_role_grants.dev_grants](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/role_grants) | resource |
| [snowflake_user.dbt_service_users](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/user) | resource |
| [snowflake_warehouse.dbt_warehouses](https://registry.terraform.io/providers/Snowflake-Labs/snowflake/latest/docs/resources/warehouse) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_envs"></a> [database\_envs](#input\_database\_envs) | The different environments required (i.e. DEV, PROD etc...) and their properties | <pre>map(object({<br>    wh_size           = string<br>    defer_to_env_name = string<br>    git_branch        = string<br>  }))</pre> | n/a | yes |
| <a name="input_defer_from_to"></a> [defer\_from\_to](#input\_defer\_from\_to) | Map of all the environments that can defer to another one in CI. Key and Value are the environment names | <pre>map(object({<br>    defer_to_env_name = string<br>  }))</pre> | n/a | yes |
| <a name="input_developers"></a> [developers](#input\_developers) | List of user IDs to assign the new developer role to | `set(string)` | n/a | yes |
| <a name="input_envs_except_dev"></a> [envs\_except\_dev](#input\_envs\_except\_dev) | The deployment environments. A subset of `database_envs`. | `map(any)` | n/a | yes |
| <a name="input_project_slug"></a> [project\_slug](#input\_project\_slug) | Slug for the project with no special characters | `string` | n/a | yes |
| <a name="input_raw_database"></a> [raw\_database](#input\_raw\_database) | The name of the database where the raw data is stored | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_snowflake_databases"></a> [snowflake\_databases](#output\_snowflake\_databases) | n/a |
| <a name="output_snowflake_roles"></a> [snowflake\_roles](#output\_snowflake\_roles) | n/a |
| <a name="output_snowflake_users"></a> [snowflake\_users](#output\_snowflake\_users) | n/a |
| <a name="output_snowflake_warehouses"></a> [snowflake\_warehouses](#output\_snowflake\_warehouses) | n/a |
<!-- END_TF_DOCS -->