variable "tools" {
  default = {

    workstation = {
      instance_type = "t3.medium"
      policy_name = ["AdministratorAccess"]
      ports         = {
        ssh = 22
        http = 80
        https = 443
      }
      volume_size   = 30
    }
    github-runner = {
      instance_type = "t3.small"
      policy_name = ["AdministratorAccess"]
      ports         = {
      }
      volume_size   = 30
    }
    vault = {
      instance_type = "t3.small"
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

