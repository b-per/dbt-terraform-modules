terraform {
  required_version = ">= 1.3"

  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
    null = {
      source  = "hashicorp/null"
      version = ">= 3.0"
    }
  }
}

resource "github_repository" "dbt_repo" {
    name        = "dbt_${var.project_slug}"
    description = "Code for the dbt project ${var.project_name}"

    visibility = "public"
    auto_init  = false
}


resource "github_branch_protection" "dbt_repo" {
  repository_id = github_repository.dbt_repo.node_id
  pattern          = "main"
  enforce_admins   = false

  required_pull_request_reviews {
    restrict_dismissals    = false
    required_approving_review_count = 1

  }
}

# this will happen only when the repo is created
resource "null_resource" "post_repo_creation" {
  provisioner "local-exec" {
    command = <<-EOT
      #!/bin/bash
      # Do something locally once the repo is created
      mkdir cruft-template
      cd cruft-template
      cruft create ${var.cruft_template_url} --extra-context '{"project_name": "${var.project_name}", "project_slug": "${var.project_slug}"}' --no-input
      cd ${var.project_slug}
      git config --global init.defaultBranch main
      git init
      git config user.email "nomail@mail.com"
      git config user.name "No name"
      git add *
      git commit -m "Initial commit from Terraform and cruft"
      git branch -M main
      git remote add origin ${github_repository.dbt_repo.http_clone_url}
      git push -u origin main
      cd ../..
      rm -rf cruft-template
      EOT

    environment = {
      GH_TOKEN = var.github_token
    }
  }
}
