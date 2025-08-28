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


