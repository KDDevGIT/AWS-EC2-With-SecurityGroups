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



