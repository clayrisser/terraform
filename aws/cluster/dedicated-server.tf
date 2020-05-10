resource "aws_launch_configuration" "dedicated" {
  iam_instance_profile = aws_iam_instance_profile.cluster.name
  image_id             = var.ami
  instance_type        = "t2.large"
  key_name             = aws_key_pair.ssh_key.key_name
  security_groups      = [aws_security_group.cluster.name]
  user_data            = data.template_file.dedicated_cloudconfig.rendered
  root_block_device {
    volume_type = "gp2"
    volume_size = "40"
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [
      arn,
      ebs_optimized,
      id,
      name,
      user_data,
      ebs_block_device,
      root_block_device
    ]
  }
}

resource "aws_autoscaling_group" "dedicated" {
  availability_zones        = [for availability_zone in var.availability_zones: "${var.region}${availability_zone}"]
  depends_on                = [aws_launch_configuration.dedicated]
  desired_capacity          = var.dedicated_desired_capacity
  force_delete              = true
  health_check_grace_period = 300
  health_check_type         = "EC2"
  launch_configuration      = aws_launch_configuration.dedicated.name
  max_size                  = var.dedicated_desired_capacity + 2
  min_size                  = max(var.dedicated_desired_capacity - 2, 1)
  name                      = "${var.name}-dedicated"
  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_id}"
    value               = "owned"
    propagate_at_launch = true
  }
  tag {
    key                 = "spot-enabled"
    value               = "false"
    propagate_at_launch = true
  }
  tag {
    key                 = "Name"
    value               = "${var.name}-dedicated-${aws_launch_configuration.dedicated.name}"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
    ignore_changes = [
      tag
    ]
  }
}

data "template_file" "dedicated_cloudconfig" {
  template = file("dedicated-cloud-config.yml")
  vars = {
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    command        = var.command
    docker_version = var.docker_version
    region         = var.region
  }
}
