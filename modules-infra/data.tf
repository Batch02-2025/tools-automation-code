data "aws_ami" "rhel9" {
  most_recent     = true
  name_regex      = "Red Hat Enterprise Linux 9 (HVM), SSD Volume Type"
  architecture    = "x86_64"
  owners          = ["959620655822"]

  filter {
    name = "Red Hat Enterprise Linux version 9 (HVM), EBS General Purpose (SSD) Volume Type"
    values = ["ami-*"]
  }
}

data "aws_key_pair" "key" {
  key_name = var.key_name
}
