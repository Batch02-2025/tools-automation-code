variable "tools" {
  default = {

    github-runner = {
      instance_type = "t2.small"
      policy_name = ["AdministratorAccess"]
      ports         = {}
      volume_size   = 30
    }
    vault = {
      instance_type = "t2.small"
      policy_name = []
      ports         = {
        vault = 8200
      }
      volume_size  = 20
    }
 }
}

variable "key_name" {
  type = string
  default = "ec2-B2key"
}

