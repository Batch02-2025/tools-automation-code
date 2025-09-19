resource "aws_instance" "tool" {
  # ami                     = data.aws_ami.rhel9.image_id
  ami                     = "ami-07378eee6a8e82f97"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.tool_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.instance-profile.name
  key_name                = data.aws_key_pair.key.key_name

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group" "tool_sg" {
  name        = "${var.name}-sg"
  description = "${var.name}-sg"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port         = -1  # -1 for all ICMP types
    to_port           = -1  # -1 for all ICMP codes
    protocol          = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name  = "${var.name}-sg"
  }
}