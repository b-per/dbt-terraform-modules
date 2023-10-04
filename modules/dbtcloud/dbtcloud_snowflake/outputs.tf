output "dbt_connection" {
  value = dbtcloud_connection.dbt_connection
}

output "dbt_creds" {
  value = dbtcloud_snowflake_credential.creds
}

output "dbt_creds_ci" {
  value = dbtcloud_snowflake_credential.creds_ci
}