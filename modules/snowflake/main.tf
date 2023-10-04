
terraform {
  required_version = ">= 1.3"

  required_providers {
    snowflake = {
      source  = "Snowflake-Labs/snowflake"
      version = "~> 0.71"
    }
  }
}


locals {
    upper_project = upper(var.project_slug)

    set_envs = [for env in keys(var.database_envs) : env]
    set_env_table_view = setproduct(local.set_envs, ["TABLES", "VIEWS"])
    
    defer_from_to_table_view = flatten([
    for key, value in var.defer_from_to : [
      for item in ["TABLES", "VIEWS"] : {
        env        = key
        defer_to   = value.defer_to_env_name
        item_type  = item
      }
    ]
  ])

}

resource "snowflake_database" "dbt_databases" {
  for_each = var.database_envs
  name     = "DBT_${local.upper_project}_${each.key}"
  comment  = "dbt project ${local.upper_project} - ${each.key}"
}

resource "snowflake_warehouse" "dbt_warehouses" {
  for_each       = var.database_envs
  name           = "DBT_WH_${local.upper_project}_${each.key}"
  comment        = "Warehouse for the project ${local.upper_project} - ${each.key}"
  warehouse_size = each.value["wh_size"]
}

resource "snowflake_role" "dbt_roles" {
  for_each = var.database_envs
  name     = "DBT_ROLE_${local.upper_project}_${each.key}"
  comment  = "Role for the project ${local.upper_project} - ${each.key}"
}

resource "snowflake_grant_privileges_to_role" "warehouse" {
  for_each = var.database_envs
  role_name = snowflake_role.dbt_roles[each.key].name
  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.dbt_warehouses[each.key].name
  }
  privileges = ["USAGE"]
}

resource "snowflake_grant_privileges_to_role" "database" {
  for_each = var.database_envs
  role_name = snowflake_role.dbt_roles[each.key].name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.dbt_databases[each.key].name
  }
  privileges = ["USAGE", "CREATE SCHEMA"]
}

resource "snowflake_grant_privileges_to_role" "schemas" {
  for_each = var.database_envs
  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt_roles[each.key].name
  on_schema {
    all_schemas_in_database = snowflake_database.dbt_databases[each.key].name
  }
}

resource "snowflake_grant_privileges_to_role" "future_schemas" {
  for_each = var.database_envs
  privileges = ["USAGE", "CREATE VIEW", "CREATE TABLE"]
  role_name = snowflake_role.dbt_roles[each.key].name
  on_schema {
    future_schemas_in_database = snowflake_database.dbt_databases[each.key].name
  }
}

resource "snowflake_grant_privileges_to_role" "existing_tables_views" {
  for_each = { for idx, val in local.set_env_table_view : join("_",concat(val)) => val }
  role_name  = snowflake_role.dbt_roles[each.value[0]].name
  on_schema_object {
    all {
      object_type_plural = each.value[1]
      in_database = snowflake_database.dbt_databases[each.value[0]].name
    }
  }
  all_privileges = true
}

resource "snowflake_grant_privileges_to_role" "future_tables_views" {
  for_each = { for idx, val in local.set_env_table_view : join("_",concat(val)) => val }
  role_name  = snowflake_role.dbt_roles[each.value[0]].name
  on_schema_object {
    future {
      object_type_plural = each.value[1]
      in_database        = snowflake_database.dbt_databases[each.value[0]].name
    }
  }
  all_privileges = true
}


resource "snowflake_grant_privileges_to_role" "raw_usage_all_schemas" {
  for_each = var.database_envs
  privileges = ["USAGE"]
  role_name  = snowflake_role.dbt_roles[each.key].name
  on_schema {
    all_schemas_in_database = var.raw_database 
  }
}

resource "snowflake_grant_privileges_to_role" "raw_usage_future_schemas" {
  for_each = var.database_envs
  privileges = ["USAGE"]
  role_name = snowflake_role.dbt_roles[each.key].name
  on_schema {
    future_schemas_in_database = var.raw_database
  }
}

# There are most likely already tables and views in the raw database
resource "snowflake_grant_privileges_to_role" "raw_current_tables_views" {
  for_each = { for idx, val in local.set_env_table_view : join("_",concat(val)) => val }
  privileges = ["SELECT"]
  role_name  = snowflake_role.dbt_roles[each.value[0]].name
  on_schema_object {
    all {
      object_type_plural = each.value[1]
      in_database = var.raw_database 
    }
  }
}

# There will be more tables and views in the raw database
resource "snowflake_grant_privileges_to_role" "raw_future_tables_views" {
  for_each = { for idx, val in local.set_env_table_view : join("_",concat(val)) => val }
  privileges = ["SELECT"]
  role_name  = snowflake_role.dbt_roles[each.value[0]].name
  on_schema_object {
    future {
      object_type_plural = each.value[1]
      in_database        = var.raw_database
    }
  }
}


# Assign dev role to users
resource "snowflake_role_grants" "dev_grants" {
    role_name = snowflake_role.dbt_roles["DEV"].name

    # we provide DEV access to the non DEV roles
    roles = [
        for env_name, vals in var.envs_except_dev : snowflake_role.dbt_roles[env_name].name
    ]

    users = [
        for user in var.developers : user
    ]
}


resource "random_password" "password" {
  for_each = var.envs_except_dev
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "snowflake_user" "dbt_service_users" {
  for_each = var.envs_except_dev
  name         = "DBT_${local.upper_project}_SERVICE_${each.key}"
  password     = random_password.password[each.key].result
  disabled     = false
  display_name = "dbt service user for ${local.upper_project} - ${each.key}"

  default_warehouse       = snowflake_warehouse.dbt_warehouses[each.key].name
  default_role            = snowflake_role.dbt_roles[each.key].name
  must_change_password    = false
}

resource "snowflake_role_grants" "dbt_service_user_grants" {
  for_each = var.envs_except_dev
  role_name = snowflake_role.dbt_roles[each.key].name

  users = [
    snowflake_user.dbt_service_users[each.key].name
  ]
}


resource "snowflake_grant_privileges_to_role" "deferral_database" {
  for_each = var.defer_from_to
  role_name = snowflake_role.dbt_roles[each.key].name
  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.dbt_databases[each.value["defer_to_env_name"]].name
  }
  privileges = ["USAGE"]
}


resource "snowflake_grant_privileges_to_role" "deferral_database_schemas" {
  for_each = var.defer_from_to
  privileges = ["USAGE"]
  role_name = snowflake_role.dbt_roles[each.key].name
  on_schema {
    all_schemas_in_database = snowflake_database.dbt_databases[each.value["defer_to_env_name"]].name
  }
}

resource "snowflake_grant_privileges_to_role" "deferral_database_future_schemas" {
  for_each = var.defer_from_to
  privileges = ["USAGE"]
  role_name = snowflake_role.dbt_roles[each.key].name
  on_schema {
    future_schemas_in_database = snowflake_database.dbt_databases[each.value["defer_to_env_name"]].name
  }
}

resource "snowflake_grant_privileges_to_role" "deferral_existing_tables_views" {
  for_each = { for idx, val in local.defer_from_to_table_view : join("_", [val["env"], val["item_type"]]) => val }
  privileges = ["SELECT"]
  role_name  = snowflake_role.dbt_roles[each.value["env"]].name
  on_schema_object {
    all {
      object_type_plural = each.value["item_type"]
      in_database = snowflake_database.dbt_databases[each.value["defer_to"]].name
    }
  }
}

resource "snowflake_grant_privileges_to_role" "deferral_future_tables_views" {
  for_each = { for idx, val in local.defer_from_to_table_view : join("_", [val["env"], val["item_type"]]) => val }
  privileges = ["SELECT"]
  role_name  = snowflake_role.dbt_roles[each.value["env"]].name
  on_schema_object {
    future {
      object_type_plural = each.value["item_type"]
      in_database = snowflake_database.dbt_databases[each.value["defer_to"]].name
    }
  }
}
