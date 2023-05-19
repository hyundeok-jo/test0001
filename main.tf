data "aws_organizations_organization" "main" {}

data "aws_organizations_organizational_units" "parent" {
  parent_id = data.aws_organizations_organization.main.roots[0].id
}

data "aws_organizations_organizational_units" "ou" {
  parent_id = [for x in data.aws_organizations_organizational_units.parent.children : x.id if x.name == "Sandbox"][0]
}

module "account" {
  source = "./module/account"
  name_to_find = "hyun22"
}
