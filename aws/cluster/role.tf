resource "aws_iam_role" "cluster" {
  assume_role_policy = file("assume-role-policy.json")
  name               = var.name
}

resource "aws_iam_policy" "cluster" {
  description = "rancher node policy"
  name        = var.name
  policy      = file("policy.json")
}

resource "aws_iam_policy_attachment" "cluster" {
  name       = var.name
  policy_arn = aws_iam_policy.cluster.arn
  roles      = [aws_iam_role.cluster.name]
}

resource "aws_iam_instance_profile" "cluster" {
  name = var.name
  role = aws_iam_role.cluster.name
}
