
output "snowflake_users" {
  value = snowflake_user.dbt_service_users
}

output "snowflake_warehouses" {
  value = snowflake_warehouse.dbt_warehouses
}

output "snowflake_databases" {
  value = snowflake_database.dbt_databases
}

output "snowflake_roles" {
  value = snowflake_role.dbt_roles
}