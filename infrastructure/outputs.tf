# Defines the output values for the Terraform deployment, such as the EC2 instance public IP or S3 bucket name.
# Why: Outputs make it easy to retrieve important information like the app’s public IP after deployment.

output "app_instance_public_ip" {
  value = aws_instance.app_instance.public_ip
}
