# # Contains variables for your AWS infrastructure, such as the region, instance type, or bucket name.
# # Why: It makes the Terraform configuration flexible by defining reusable parameters like the AWS region or instance type.

variable "aws_region" {
  description = "AWS region where resources will be provisioned"
  default     = "eu-west-1"
}


variable "ssh_public_key" {
  description = "The public key for the EC2 key pair"
  type        = string
}

variable "instance" {

}