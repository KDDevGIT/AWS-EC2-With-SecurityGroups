# Instance ID
output "instance_id" {
    value = aws_instance.web.id
}

# Public IP
output "public_ip" {
    value = aws_instance.web.public_ip
}

# HTTP URL
output "http_url" {
    value = "http://${aws_instance.web.public_ip}"
}
