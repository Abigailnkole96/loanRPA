# The main Terraform configuration file, which provisions the necessary AWS infrastructure for the project.

# Why: This sets up resources such as EC2 instances (to run the app), S3 buckets (to store model data or logs), and IAM roles (to manage permissions).

# Key Resources:

# EC2 instances to host the Flask app and RPA bot.
# S3 bucket for storing RPA process logs or machine learning models.
# IAM roles to manage access and security policies.

resource "aws_instance" "flask_app" {
  ami           = "ami-054a53dca63de757b"  # Example AMI; replace with a suitable one
  instance_type = "t2.micro"

  key_name = aws_key_pair.app_key_pair.key_name

  tags = {
    Name = "FlaskAppInstance"
  }
}

resource "aws_instance" "rpa_bot" {
  ami           = "ami-054a53dca63de757b"  # Example AMI; replace with a suitable one
  instance_type = "t2.micro"

  key_name = aws_key_pair.app_key_pair.key_name

  tags = {
    Name = "RpaBotInstance"
  }
}

resource "random_string" "bucket_suffix" {
  length  = 8
  special = false  # Ensures only alphanumeric characters are used
}

resource "aws_s3_bucket" "rpa_logs" {
  bucket = "rpa-logs-bucket-${lower(random_string.bucket_suffix.result)}" # Ensure this is unique and in lowercase

  tags = {
    Name = "RpaLogsBucket"
  }
}

output "s3_bucket_id" {
  value = aws_s3_bucket.rpa_logs.id
}

resource "aws_key_pair" "app_key_pair" {
  key_name   = "app_key_pair"
  public_key = var.ssh_public_key  # Reference the variable instead of a file

 lifecycle {
    ignore_changes = [public_key]
  }
}

output "flask_app_instance_id" {
  value = aws_instance.flask_app.id
}

output "rpa_bot_instance_id" {
  value = aws_instance.rpa_bot.id
}