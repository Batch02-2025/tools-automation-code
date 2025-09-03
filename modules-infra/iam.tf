resource "aws_iam_role" "role" {
  name = "${var.name}role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "${var.name}-role"
  }
}

resource "aws_iam_instance_profile" "instance-profile" {
  name = "${var.name}-role"
  role = aws_iam_role.role.name
}

resource "aws_iam_policy_attachment" "policy-attach" {
  count      = length(var.policy_name)
  roles      = [aws_iam_role.role.name]
  policy_arn = "arn:aws:iam::aws:policy/${var.policy_name[count.index]}"
}
