# Main Terraform configuration file to provision AWS infrastructure.

######################
# Compute resources
######################

# EC2 instance for Flask App
resource "aws_instance" "flask_app" {
  ami           = "ami-054a53dca63de757b" # Replace with your desired AMI
  instance_type = "t2.micro"

  key_name                   = aws_key_pair.app_key_pair.key_name
  iam_instance_profile       = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip git

    git clone https://github.com/Abigailnkole96/loanRPA.git /home/ubuntu/flask-app
    cd /home/ubuntu/flask-app

    pip3 install -r requirements.txt
    python3 app.py > app.log 2>&1 &
  EOF

  tags = {
    Name = "FlaskAppInstance"
  }
}

# EC2 instance for RPA Bot
resource "aws_instance" "rpa_bot" {
  ami           = "ami-054a53dca63de757b" # Replace with your desired AMI
  instance_type = "t2.micro"

  key_name                   = aws_key_pair.app_key_pair.key_name
  iam_instance_profile       = aws_iam_instance_profile.ec2_profile.name

  user_data = <<-EOF
    #!/bin/bash
    sudo apt-get update -y
    sudo apt-get install -y python3 python3-pip git

    git clone https://github.com/Abigailnkole96/loanRPA.git /home/ubuntu/ml-project
    cd /home/ubuntu/ml-project

    pip3 install -r requirements.txt
    python3 ml.py
  EOF

  tags = {
    Name = "RpaBotInstance"
  }
}

######################
# Storage resources
######################

# Generate a random suffix for the S3 bucket
resource "random_string" "bucket_suffix" {
  length  = 8
  special = false
}

# S3 bucket for logs
resource "aws_s3_bucket" "rpa_logs" {
  bucket = "rpa-logs-bucket-${random_string.bucket_suffix.result}"

  tags = {
    Name = "RpaLogsBucket"
  }
}

######################
# SSH Key Pair
######################

# SSH key pair for EC2 access
resource "aws_key_pair" "app_key_pair" {
  key_name   = "app_key_pair"
  public_key = var.ssh_public_key

  lifecycle {
    ignore_changes = [public_key]
  }
}

######################
# Permissions
######################

# IAM policy to allow EC2 instances to access S3 bucket
resource "aws_iam_policy" "s3_access_policy" {
  name   = "S3AccessPolicy"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ],
        Resource = [
          "arn:aws:s3:::${aws_s3_bucket.rpa_logs.id}",
          "arn:aws:s3:::${aws_s3_bucket.rpa_logs.id}/*"
        ]
      }
    ]
  })
}

# IAM role for EC2 instances
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_s3_access_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ec2_s3_policy_attach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Instance profile for EC2 role
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}
