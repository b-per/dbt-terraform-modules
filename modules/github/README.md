<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_github"></a> [github](#requirement\_github) | ~> 5.0 |
| <a name="requirement_null"></a> [null](#requirement\_null) | >= 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_github"></a> [github](#provider\_github) | ~> 5.0 |
| <a name="provider_null"></a> [null](#provider\_null) | >= 3.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [github_branch_protection.dbt_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/branch_protection) | resource |
| [github_repository.dbt_repo](https://registry.terraform.io/providers/integrations/github/latest/docs/resources/repository) | resource |
| [null_resource.post_repo_creation](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cruft_template_url"></a> [cruft\_template\_url](#input\_cruft\_template\_url) | URL for the Cruft template | `string` | n/a | yes |
| <a name="input_github_token"></a> [github\_token](#input\_github\_token) | GitHub token to crate repos | `string` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Project Name | `string` | n/a | yes |
| <a name="input_project_slug"></a> [project\_slug](#input\_project\_slug) | Slug for the project | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_github_repo_remote_url"></a> [github\_repo\_remote\_url](#output\_github\_repo\_remote\_url) | n/a |
<!-- END_TF_DOCS -->