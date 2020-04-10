resource "aws_instance" "dedicated_etcd" {
  ami                         = var.ami
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.nodes.name
  instance_type               = var.dedicated_instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  security_groups             = [aws_security_group.nodes.name]
  user_data                   = data.template_file.dedicated_etcd_cloudconfig.rendered
  root_block_device  {
    volume_type = "gp2"
    volume_size = var.volume_size
  }
  tags = {
    "kubernetes.io/cluster/${var.cluster_id}" = "owned"
    Name = "${var.name}-etcd"
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = [
      ami,
      arn,
      availability_zone,
      cpu_core_count,
      cpu_threads_per_core,
      credit_specification,
      disable_api_termination,
      ebs_block_device,
      ebs_optimized,
      ephemeral_block_device,
      host_id,
      id,
      instance_state,
      ipv6_address_count,
      ipv6_addresses,
      monitoring,
      network_interface,
      network_interface_id,
      password_data,
      placement_group,
      primary_network_interface_id,
      private_dns,
      private_ip,
      public_dns,
      public_ip,
      root_block_device,
      subnet_id,
      tags,
      tenancy,
      user_data,
      volume_tags,
      vpc_security_group_ids
    ]
  }
}

resource "aws_instance" "dedicated_entrypoint" {
  ami                         = var.ami
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.nodes.name
  instance_type               = var.dedicated_instance_type
  key_name                    = aws_key_pair.ssh_key.key_name
  security_groups             = [aws_security_group.nodes.name]
  user_data                   = data.template_file.dedicated_entrypoint_cloudconfig.rendered
  root_block_device  {
    volume_type = "gp2"
    volume_size = var.volume_size
  }
  tags = {
    "kubernetes.io/cluster/${var.cluster_id}" = "owned"
    Name = "${var.name}-entrypoint"
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = [
      arn,
      ami,
      availability_zone,
      cpu_core_count,
      cpu_threads_per_core,
      credit_specification,
      disable_api_termination,
      ebs_block_device,
      ebs_optimized,
      ephemeral_block_device,
      host_id,
      id,
      instance_state,
      ipv6_address_count,
      ipv6_addresses,
      monitoring,
      network_interface,
      network_interface_id,
      password_data,
      placement_group,
      primary_network_interface_id,
      private_dns,
      private_ip,
      public_dns,
      public_ip,
      root_block_device,
      subnet_id,
      tenancy,
      user_data,
      volume_tags,
      vpc_security_group_ids
    ]
  }
}

data "template_file" "dedicated_etcd_cloudconfig" {
  template = file("dedicated-etcd-cloud-config.yml")
  vars = {
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    command        = var.command
    docker_version = var.docker_version
    region         = var.region
  }
}

data "template_file" "dedicated_entrypoint_cloudconfig" {
  template = file("dedicated-entrypoint-cloud-config.yml")
  vars = {
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    command        = var.command
    docker_version = var.docker_version
    region         = var.region
  }
}

resource "aws_eip" "dedicated_entrypoint" {
  instance = aws_instance.dedicated_entrypoint.id
  vpc      = true
  tags = {
    Name = var.name
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = false
    ignore_changes = []
  }
}

# resource "aws_launch_configuration" "dedicated_node" {
#   image_id        = var.ami
#   instance_type   = var.dedicated_instance_type
#   key_name        = aws_key_pair.ssh_key.key_name
#   security_groups = [aws_security_group.nodes.name]
#   user_data       = data.template_file.dedicated_cloudconfig.rendered
#   root_block_device {
#     volume_type = "gp2"
#     volume_size = var.volume_size
#   }
# }

# resource "aws_autoscaling_group" "dedicated_nodes" {
#   depends_on                = ["aws_launch_configuration.dedicated_node"]
#   availability_zones        = ["${var.region}a", "${var.region}b", "${var.region}c"]
#   name                      = "dedicated-${var.name}"
#   max_size                  = var.dedicated_desired_capacity + 2
#   min_size                  = max(var.dedicated_desired_capacity - 2, 1)
#   health_check_grace_period = 300
#   health_check_type         = "EC2"
#   desired_capacity          = var.dedicated_desired_capacity
#   force_delete              = true
#   launch_configuration      = aws_launch_configuration.dedicated_nodes.name
#   lifecycle {
#     create_before_destroy = true
#   }
#   tag {
#     key                 = "Name"
#     value               = "dedicated_${aws_launch_configuration.dedicated_nodes.name}"
#     propagate_at_launch = true
#   }
# }
