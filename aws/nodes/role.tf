resource "aws_iam_role" "node" {
  name = "${var.name}"
  assume_role_policy = "${file("assume-role-policy.json")}"
}

resource "aws_iam_policy" "node" {
  name        = "RancherCloud"
  description = "rancher node policy"
  policy      = "${file("policy.json")}"
}

resource "aws_iam_policy_attachment" "node" {
  name       = "node"
  roles      = ["${aws_iam_role.node.name}"]
  policy_arn = "${aws_iam_policy.node.arn}"
}

resource "aws_iam_instance_profile" "node" {
  name = "node"
  role = "${aws_iam_role.node.name}"
}
