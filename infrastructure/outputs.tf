# Defines the output values for the Terraform deployment, such as the EC2 instance public IP or S3 bucket name.
# Why: Outputs make it easy to retrieve important information like the app’s public IP after deployment.

# output "flask_app_public_ip" {
#   description = "The public IP of the Flask App EC2 instance"
#   value       = aws_instance.flask_app_instance.public_ip
# }

# output "rpa_bot_public_ip" {
#   description = "The public IP of the RPA bot EC2 instance"
#   value       = aws_instance.rpa_bot_instance.public_ip
# }

# output "s3_bucket_name" {
#   description = "The name of the S3 bucket"
#   value       = aws_s3_bucket.rpa_logs_bucket.bucket
# }
