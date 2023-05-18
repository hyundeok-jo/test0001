data "aws_organizations_organization" "main" {}

data "aws_organizations_organizational_units" "parent" {
  parent_id = data.aws_organizations_organization.main.roots[0].id
}
data "aws_organizations_organizational_units" "ou" {
  parent_id = [for x in data.aws_organizations_organizational_units.parent.children : x.id if x.name == "Sandbox"][0]
}

output "children" {
  value = data.aws_organizations_organizational_units.ou.children
}


## Sandbox2 OU
data "aws_controltower_controls" "Sandbox2" {

  target_identifier = [
    for x in data.aws_organizations_organizational_units.ou.children :
    x.arn if x.name == "Sandbox2"
  ][0]

}

output "controls_security" {
  value = data.aws_controltower_controls.Sandbox2.enabled_controls
#  value = data.aws_controltower_controls.Sandbox2
}
