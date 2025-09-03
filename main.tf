module "create-tool-infra" {
  for_each        = var.tools
  source          = "./modules-infra"
  name            = each.key
  instance_type   = each.value["instance_type"]
  policy_name     = each.value["policy_name"]
  # ports           = each.value["ports"]
  # volume_size     = each.value["volume_size"]
}