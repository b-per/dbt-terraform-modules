output "github_repo_remote_url" {
  value = github_repository.dbt_repo.ssh_clone_url
}