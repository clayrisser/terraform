resource "aws_instance" "entrypoint" {
  ami                         = var.ami
  associate_public_ip_address = true
  availability_zone           = ["${var.region}${var.availability_zones[0]}"]
  iam_instance_profile        = aws_iam_instance_profile.cluster.name
  instance_type               = "t2.medium"
  key_name                    = aws_key_pair.ssh_key.key_name
  security_groups             = [aws_security_group.cluster.name]
  user_data                   = data.template_file.entrypoint_cloudconfig.rendered
  root_block_device  {
    volume_type = "gp2"
    volume_size = "40"
  }
  tags = {
    "kubernetes.io/cluster/${var.cluster_id}" = "owned"
    Name = "${var.name}-entrypoint"
  }
  lifecycle {
    create_before_destroy = true
    prevent_destroy = true
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

data "template_file" "entrypoint_cloudconfig" {
  template = file("cloud-config.yml")
  vars = {
    aws_access_key = var.aws_access_key
    aws_secret_key = var.aws_secret_key
    command        = var.command
    docker_version = var.docker_version
    region         = var.region
  }
}
