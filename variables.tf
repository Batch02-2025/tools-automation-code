variable "tools" {
  default = {

    github-runner = {
      instance_type = "t2.small"
      ports         = {}
      volume_size   = 30
    }
     vault = {
      instance_type = "t2.small"
      ports         = {
        vault = 8200
      }
      volume_size  = 20
    }
 }
}

