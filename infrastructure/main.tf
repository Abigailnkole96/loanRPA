# The main Terraform configuration file, which provisions the necessary AWS infrastructure for the project.

# Why: This sets up resources such as EC2 instances (to run the app), S3 buckets (to store model data or logs), and IAM roles (to manage permissions).

# Key Resources:

# EC2 instances to host the Flask app and RPA bot.
# S3 bucket for storing RPA process logs or machine learning models.
# IAM roles to manage access and security policies.

# EC2 Instance: This Terraform code provisions an EC2 instance to host the Flask app.
# S3 Bucket: Creates an S3 bucket to store logs or processed loan application data.

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

resource "aws_s3_bucket" "rpa_logs" {
  bucket = "rpa-logs-bucket" # Ensure this is unique
  # Add other necessary configurations
}

output "s3_bucket_id" {
  value = aws_s3_bucket.rpa_logs.id
}


resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
}

resource "aws_key_pair" "app_key_pair" {
  key_name   = "app_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")  # Ensure this path is correct
}

output "flask_app_instance_id" {
  value = aws_instance.flask_app.id
}

output "rpa_bot_instance_id" {
  value = aws_instance.rpa_bot.id
}

# output "s3_bucket_id" {
#   value = aws_s3_bucket.rpa_logs.id
# }
