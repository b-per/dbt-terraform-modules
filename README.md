# dbt-terraform-modules

Modules to set up dbt projects using Terraform

Currently these modules support:

- dbt Cloud "common" setup which doesn't depend on warehouses/adapters
- dbt Cloud Snowflake specific setup to connect dbt to a Snowflake DW
- using cruft and GitHub to create a new dbt repository in GitHub based on a template
- setting up databases, users and roles in Snowflake based on a set of environments required (e.g. DEV and PROD)

PRs are welcome to add support for more adapters, git providers or just more functionality.

Alternatively, someone could clone this repository and update the configuration on their side
