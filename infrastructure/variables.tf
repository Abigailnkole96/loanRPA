# # Contains variables for your AWS infrastructure, such as the region, instance type, or bucket name.
# # Why: It makes the Terraform configuration flexible by defining reusable parameters like the AWS region or instance type.

variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "eu-west-1"
}

# variable "instance_type" {
#   description = "The instance type for EC2"
#   default     = "t2.micro"
# }

# variable "ami_id" {
#   description = "AMI ID for EC2 instances"
#   default     = "ami-054a53dca63de757b"  # Example AMI for Ubuntu 20.04
# }

# variable "app_bucket_name" {
#   description = "S3 bucket name for RPA logs or model data"
#   default     = "loan-rpa-logs-bucket"
# }

# variable "flask_instance_name" {
#   description = "Name tag for Flask app EC2 instance"
#   default     = "FlaskAppEC2"
# }

# variable "rpa_instance_name" {
#   description = "Name tag for RPA bot EC2 instance"
#   default     = "RPAAppEC2"
# }

# variable "ssh_key_path" {
#   description = "The path to your SSH public key"
#   default     = "/home/abigailrestack/.ssh/id_rsa.pub"
# }

variable "ssh_public_key" {
  description = "The public key for the EC2 key pair"
  type        = string
}