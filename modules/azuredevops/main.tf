terraform {
  required_version = ">= 1.3"

  required_providers {
    azuredevops = {
      source  = "microsoft/azuredevops"
      version = ">= 0.1.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

provider "azuredevops" {
  org_service_url       = var.devops_url
  personal_access_token = var.devops_token
}

resource "azuredevops_git_repository" "dbt_repo" {
  project_id = var.devops_project_id
  name       = "dbt_${var.project_slug}"
  initialization {
    init_type = "Uninitialized"
  }
}

resource "azuredevops_branch_policy_min_reviewers" "dbt_repo" {
  project_id = var.devops_project_id
  enabled    = true
  blocking   = true

  settings {
    reviewer_count                         = 1
    submitter_can_vote                     = false
    last_pusher_cannot_approve             = true
    allow_completion_with_rejects_or_waits = false
    on_push_reset_approved_votes           = true
    on_last_iteration_require_vote         = false

    scope {
      repository_id  = azuredevops_git_repository.dbt_repo.id
      repository_ref = azuredevops_git_repository.dbt_repo.default_branch
      match_type     = "Exact"
    }
  }
}

locals {
  repo_url           = azuredevops_git_repository.project_repository.remote_url
  https_url_with_pat = replace(local.repo_url, "https://", "https://${var.devops_token}@")
}

resource "null_resource" "post_repo_creation" {
  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      set -e
      # Clone the template and push it to the new repo
      rm -rf cruft-template
      mkdir cruft-template
      cd cruft-template
      cruft create ${var.cruft_template_url} --extra-context '{"project_name": "${var.project_name}", "project_slug": "${var.project_slug}"}' --no-input
      cd ${var.project_slug}
      git config --global init.defaultBranch main
      git init
      git config user.email "nomail@dbt.com"
      git config user.name "Created by Terraform"
      git add -A
      git commit -m "Initial commit from Terraform and cruft"
      git branch -M main
      git remote add origin ${local.https_url_with_pat}
      git push -u origin main
      cd ../..
      rm -rf cruft-template
      EOT

    environment = {
      TOKEN = var.devops_token
    }
  }
}
