variable "tools" {
  default = {
    workstation = {
      instance_type = "t3.medium"
      ports = {
        ssh  = 22
        http = 80
        https = 443
      }
      volume_size = 30
      policy_name = [
        # Define multiple policy objects here
        {
          name = "AdministratorAccess"
          arn  = "arn:aws:iam::aws:policy/AdministratorAccess"
        },
        {
          name = "AmazonS3FullAccess"
          arn  = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
        },
        # Add more policies as needed
      ]
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

