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
