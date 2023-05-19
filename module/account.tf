variable "name_to_find" {
  description = "The account name to find"
  type        = string
}

data "aws_organizations_organization" "example" {}

locals {
  account_map = { for account in data.aws_organizations_organization.example.accounts : account.name => account.id }
  matching_id = local.account_map[var.name_to_find]
}

output "account_ids" {
  value = data.aws_organizations_organization.example.accounts[*].*
}

output "matching_account_id" {
  value = local.matching_id
}
