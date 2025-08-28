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

