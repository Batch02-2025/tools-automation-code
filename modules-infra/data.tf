data "aws_instance" "rhel9" {
  most_recent     = true
  name_regex      = "Red Hat Enterprise Linux 9 (HVM), SSD Volume Type"
  owners          = ["959620655822"]
}