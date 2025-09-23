terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
}
resource "aws_instance" "tool" {
  ami                     = data.aws_ami.rhel9.image_id
  # ami                     = "ami-07378eee6a8e82f97"
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.tool_sg.id]
  iam_instance_profile    = aws_iam_instance_profile.instance-profile.name
  key_name                = data.aws_key_pair.key.key_name

  user_data = <<-EOF
    #! /bin/bash

    # Update the System
    sudo dnf update -y
    sudo dnf upgrade -y
    sudo hostnamectl set-hostname ${var.name} --static

    # Download the latest EPEL release RPM for RHEL 9
    sudo curl -O https://dl.fedoraproject.org/pub/epel/epel-release-latest-9.noarch.rpm

    # Install it manually
    sudo rpm -ivh epel-release-latest-9.noarch.rpm

    # Clean and refresh DNF
    sudo dnf clean all
    sudo dnf makecache

    #  Install Basic Utilities

    sudo dnf install vim wget git unzip net-tools bind-utils telnet traceroute nmap htop tree bash-completion iputils python3.11-pip -y

    # Security & Networking Tools
    sudo dnf install -y tcpdump openssl openssh-clients
  EOF

  tags = {
    Name = "${var.name}"
  }
}

resource "aws_security_group" "tool_sg" {
  name        = "${var.name}-sg"
  description = "${var.name}-sg"

  tags = {
    Name = "${var.name}-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  ip_protocol = "tcp"
  from_port   = 22
  to_port     = 22
  cidr_blocks = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow SSH inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "icmp" {
  ip_protocol = "icmp"
  from_port   = -1
  to_port     = -1
  cidr_blocks = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow ICMP inbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "app_port" {
  for_each    = var.ports
  ip_protocol = "tcp"
  from_port   = each.value
  to_port     = each.value
  cidr_blocks = "0.0.0.0/0"
  security_group_id = aws_security_group.tool_sg.id
  description = "Allow ${var.name} port ${var.ports[var.name]}"
}

resource "aws_vpc_security_group_egress_rule" "egress_allow_all" {
  ip_protocol       = "-1"
  security_group_id = aws_security_group.tool_sg.id
  cidr_ipv4 = "0.0.0.0/0"
}

