<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_azuredevops"></a> [azuredevops](#requirement\_azuredevops) | >= 0.1.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [azuredevops](#provider\_azuredevops) | >= 0.1.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azuredevops_branch_policy_min_reviewers.dbt_repo](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/branch_policy_min_reviewers) | resource |
| [azuredevops_git_repository.dbt_repo](https://registry.terraform.io/providers/microsoft/azuredevops/latest/docs/resources/git_repository) | resource |
| [null_resource.post_repo_creation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cruft_template_url"></a> [cruft\_template\_url](#input\_cruft\_template\_url) | URL for the Cruft template | `string` | n/a | yes |
| <a name="input_devops_token"></a> [devops\_token](#input\_azuredevops\_token) | DevOps token to create repos | `string` | n/a | yes |
| <a name="input_devops_url"></a> [devops\_url](#input\_azuredevops\_url) | DevOps organization URL | `string` | n/a | yes |
| <a name="input_devops_project_id"></a> [devops\_project_id](#input\_azuredevops\_project_id) | DevOps Project ID | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |
| <a name="input_project_slug"></a> [project\_slug](#input\_project\_slug) | Slug for the project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_devops_repo_remote_url"></a> [devops\_repo\_remote\_url](#output\_azuredevops\_repo\_remote\_url) | HTTPS URL for the created repository |
<!-- END_TF_DOCS -->