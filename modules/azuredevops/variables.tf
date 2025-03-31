variable "devops_token" {
  description = "Azure DevOps PAT"
  type        = string
}

variable "devops_url" {
  description = "Azure DevOps Organization URL"
  type        = string
}

variable "devops_project_id" {
  description = "Azure DevOps Project ID"
  type        = string
}

variable "project_slug" {
  description = "Slug for the project"
  type        = string
}

variable "project_name" {
  description = "Project Name"
  type        = string
}

variable "cruft_template_url" {
  description = "URL for the Cruft template"
  type        = string
}
