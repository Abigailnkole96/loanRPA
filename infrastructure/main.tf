# The main Terraform configuration file, which provisions the necessary AWS infrastructure for the project.

# Why: This sets up resources such as EC2 instances (to run the app), S3 buckets (to store model data or logs), and IAM roles (to manage permissions).

# Key Resources:

# EC2 instances to host the Flask app and RPA bot.
# S3 bucket for storing RPA process logs or machine learning models.
# IAM roles to manage access and security policies.

######################
# Compute resources
######################

resource "aws_instance" "flask_app" {
  ami           = "ami-054a53dca63de757b" # Replace with your desired AMI
  instance_type = "t2.micro"

  key_name = aws_key_pair.app_key_pair.key_name

  user_data = <<-EOF
    #!/bin/bash
    # Update packages and install dependencies
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip git

    # Clone your Flask app repository
    git clone https://github.com/Abigailnkole96/loanRPA.git

    # Navigate to the app folder
    cd /home/ubuntu/flask-app

    # Install Python dependencies
    pip3 install -r requirements.txt

    # Run the Flask app
    python3 app.py > app.log 2>&1 &
  EOF

  tags = {
    Name = "FlaskAppInstance"
  }
}



# resource "aws_instance" "flask_app" {
#   ami           = "ami-054a53dca63de757b" 
#   instance_type = "t2.micro"

#   key_name = aws_key_pair.app_key_pair.key_name

#   tags = {
#     Name = "FlaskAppInstance"
#   }
# }

resource "aws_instance" "rpa_bot" {
  ami           = "ami-054a53dca63de757b" 
  instance_type = "t2.micro"

  key_name = aws_key_pair.app_key_pair.key_name

  tags = {
    Name = "RpaBotInstance"
  }
}

######################
# Storage resources
######################
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false # Ensures only alphanumeric characters are used
}

resource "aws_s3_bucket" "rpa_logs" {
  bucket = "rpa-logs-bucket-${lower(random_string.bucket_suffix.result)}" # Ensure this is unique and in lowercase

  tags = {
    Name = "RpaLogsBucket"
  }
}


resource "aws_key_pair" "app_key_pair" {
  key_name   = "app_key_pair"
  public_key = var.ssh_public_key # Reference the variable instead of a file

  lifecycle {
    ignore_changes = [public_key]
  }
}


######################
# Permissions
######################

## policies to allow EC2 instances to access the S3 bucket 

resource "aws_iam_policy" "s3_access" {
  name = "S3AccessPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = ["s3:PutObject", "s3:GetObject"],
        Resource = ["arn:aws:s3:::rpa-logs-bucket-*/*"]
      }
    ]
  })
}
