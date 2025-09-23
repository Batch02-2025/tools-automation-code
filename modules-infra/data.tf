data "aws_ami" "rhel9" {
  most_recent = true
  owners      = ["959620655822"]

  filter {
    name   = "name"
    values = ["Red Hat Enterprise Linux 9 (HVM), SSD Volume Type*"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


data "aws_key_pair" "key" {
  key_name = var.key_name
}
