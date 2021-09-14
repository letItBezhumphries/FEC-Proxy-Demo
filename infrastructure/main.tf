
provider "aws" {
  region = var.AWS_REGION
}


terraform {
  backend "s3" {
    bucket  = "fec-brokentable-tfstate"
    region  = "us-west-2"
    key     = "modules/proxy.tfstate"
    encrypt = true
  }
}

# locals to attach to resources
# workspace will be either - develop, staging, master
locals {
  prefix = "${var.prefix}-${terraform.workspace}"
  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    ManagedBy   = "Terraform"
    Owner       = "Eric Humphries"
  }
}

resource "aws_launch_configuration" "proxy-launchconfig" {
  name_prefix     = "proxy-launchconfig"
  image_id        = var.AMI_ID
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.mykeypair.key_name
  security_groups = [aws_security_group.proxy-instance-sg.id]

  user_data       = data.template_cloudinit_config.cloudinit-install-script.rendered
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "brokentable-autoscaling" {
  name                      = "brokentable-autoscaling"
  vpc_zone_identifier       = [aws_subnet.main-public-1.id, aws_subnet.main-public-2.id]
  launch_configuration      = aws_launch_configuration.proxy-launchconfig.name
  min_size                  = 1
  max_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  load_balancers            = [aws_elb.brokentable-elb.name]
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ec2 proxy instance"
    propagate_at_launch = true
  }
}