resource "aws_iam_role" "nodes" {
  name = var.name
  assume_role_policy = file("assume-role-policy.json")
}

resource "aws_iam_policy" "nodes" {
  name        = "RancherNode"
  description = "rancher node policy"
  policy      = file("policy.json")
}

resource "aws_iam_policy_attachment" "nodes" {
  name       = var.name
  roles      = [aws_iam_role.nodes.name]
  policy_arn = aws_iam_policy.nodes.arn
}

resource "aws_iam_instance_profile" "nodes" {
  name = var.name
  role = aws_iam_role.nodes.name
}
