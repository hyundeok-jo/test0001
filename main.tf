data "aws_organizations_organization" "main" {}

data "aws_organizations_organizational_units" "parent" {
  parent_id = data.aws_organizations_organization.main.roots[0].id
}
data "aws_organizations_organizational_units" "ou" {
  parent_id = [for x in data.aws_organizations_organizational_units.parent.children : x.id if x.name == "Sandbox"][0]
}


data "aws_organizations_organization" "example" {}

output "account_ids" {
#  value = data.aws_organizations_organization.example.accounts[*].name
  value = data.aws_organizations_organization.example.accounts[*].*

}



locals {
  account_map = { for account in data.aws_organizations_organization.example.accounts : account.name => account.id... }
  name_to_find = "hyun22"
  matching_id = local.account_map[local.name_to_find]
}

output "matching_account_id" {
  value = local.matching_id
}
