
resource "aws_instance" "tool" {
  ami                     = data.aws_ami.rhel9.image_id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.tool_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.instance-profile.name
  key_name                = data.aws_key_pair.key.key_name

  user_data = base64encode(templatefile("${path.module}/userdata.sh", {
   role_name = var.name
  }))

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group" "tool_sg" {
  name        = "${var.name}-sg"
  description = "${var.name}-sg"
  vpc_id      = data.aws_vpc.vpc.id

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_ipv4 = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow SSH inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_ipv4 = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow ICMP inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "app_port" {
  for_each    = var.ports
  ip_protocol = "tcp"
  from_port   = each.value
  to_port     = each.value
  cidr_ipv4 = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow ${var.name} port ${var.ports[var.name]}"
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_all" {
  ip_protocol       = "-1"
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
}

