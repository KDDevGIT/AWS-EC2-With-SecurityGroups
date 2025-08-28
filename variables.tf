# Region
variable "region" {
    description = "AWS Region for deployment"
    type = string
    default = "us-east-1"
}

# Profile
variable "profile" {
    description = "AWS CLI Profile Name"
    type = string
    default = null
}

# Instance Type -> EC2
variable "instance_type" {
    description = "EC2 Instance Type"
    type = string
    default = "t3.micro" # For Free Tier
}

# Boolean for enabling Spot Instance
variable "use_spot" {
    description = "Launch as Spot Instance to Lower Cost"
    type = bool
    default = false
}

# Boolean for enabling SSH
variable "enable_ssh" {
    description = "Toggle for Allowing SSH from IP"
    type = bool
    default = false
}

# Key Pair for EC2 for SSH
variable "key_name" {
    description = "Existing EC2 key pair name to use for SSH"
    type = string
    default = null
}

# Allowed CIDR Block for SSH (Port 20)
variable "allowed_ssh_cidr" {
    description = "CIDR block allowed to SSH (Public IP)"
    type = string
    default = "0.0.0.0/32" # Can be changed if enabled
}

# Allowed CIDR Block for HTTP (Port 80)
variable "http_cidr" {
    description = "CIDR allowed to reach HTTP (Port 80)"
    type = string
    default = "0.0.0.0/0"
}

# Instance Name Tag
variable "instance_name" {
    description = "Name Tag for EC2 Instance"
    type = string
    default = "terraform-ec2-web"
}





