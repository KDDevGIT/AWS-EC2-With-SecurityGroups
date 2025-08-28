# Latest Amazon Linux AMI for cost reduction 
data "aws_ami" "al2023" {
    most_recent = true
    owners = ["amazon"]

    filter {
        name = "name"
        values = ["al2023-ami-2023.*-x86_64"]
    }

    filter {
        name = "architecture"
        values = ["x86_64"]
    }

    filter {
        name = "virtualization-type"
        values = ["hvm"]
    }
}

# IAM Role and Instance Profile for SSM
resource "aws_iam_role" "ssm_role" {
    name = "ec2-ssm-role"
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Principal = { Service = "ec2.amazonaws.com"}
        }]
    })
}

# IAM Role Policy Attachment
resource "aws_iam_role_policy_attachment" "ssm_core" {
    role = aws_iam_role.ssm_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# IAM Instance Profile Attachment
resource "aws_iam_instance_profile" "ssm_profile" {
    name = "ec2-ssm-instance-profile"
    role = aws_iam_role.ssm_role.name
}

# Security Group Definition 
resource "aws_security_group" "web_sg" {
    name = "web-sg"
    description = "Allow HTTP and Optional SSH"
    vpc_id = data.aws_vpc.default.id

    ingress {
        description = "HTTP"
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = [var.http_cidr]
    }

    dynamic "ingress" {
      for_each = var.enable_ssh ? [1] : []
      content {
        description = "SSH"
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = [var.allowed_ssh_cidr]
      }
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
      Name = "web-sg"
    }
}

# Use default VPC and Default Subnet per region
data "aws_vpc" "default" {
    default = true
}

data "aws_subnets" "default" {
    filter {
        name = "vpc-id"
        values = [data.aws_vpc.default.id]
    }
}

# Pick first default subnet 
locals {
    subnet_id = data.aws_subnets.default.ids[0]
}

# Web Page using nginx
locals {
    user_data = <<-EOF
    #!/bin/bash
    dnf -y update
    dnf -y install nginx
    systemctl enable nginx
    echo "<h1>Deployed with Terraform</h1>" > /usr/share/nginx/html/index.html
    systemctl start nginx
    EOF
}





