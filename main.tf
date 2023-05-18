
locals {
  account_map = { for account in data.aws_organizations_organization.example.accounts : account.name => account.id... }
  name_to_find = "hyun22"
  matching_id = local.account_map[local.name_to_find]

  #matching_id = local.account_map[module.account_request_01.control_tower_parameters.AccountName]
}

output "matching_account_id" {
  value = local.matching_id
}
