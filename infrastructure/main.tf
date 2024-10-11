# The main Terraform configuration file, which provisions the necessary AWS infrastructure for the project.

# Why: This sets up resources such as EC2 instances (to run the app), S3 buckets (to store model data or logs), and IAM roles (to manage permissions).

# Key Resources:

# EC2 instances to host the Flask app and RPA bot.
# S3 bucket for storing RPA process logs or machine learning models.
# IAM roles to manage access and security policies.

# EC2 Instance: This Terraform code provisions an EC2 instance to host the Flask app.
# S3 Bucket: Creates an S3 bucket to store logs or processed loan application data.

provider "aws" {
  region = "eu-west-1"
}

resource "aws_instance" "app_instance" {
  ami           = "ami-054a53dca63de757b"
  instance_type = "t2.micro"

  tags = {
    Name = "LoanRPAApp"
  }
}

resource "aws_s3_bucket" "rpa_bucket" {
  bucket = "loan-rpa-app-bucket"
}
