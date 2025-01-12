# Defines the output values for the Terraform deployment, such as the EC2 instance public IP or S3 bucket name.
# Why: Outputs make it easy to retrieve important information like the app’s public IP after deployment.

output "flask_app_instance_id" {
  value = aws_instance.flask_app.id
}

output "rpa_bot_instance_id" {
  value = aws_instance.rpa_bot.id
}

output "s3_bucket_id" {
  value = aws_s3_bucket.rpa_logs.id
}
