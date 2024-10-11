# Contains variables for your AWS infrastructure, such as the region, instance type, or bucket name.
# Why: It makes the Terraform configuration flexible by defining reusable parameters like the AWS region or instance type.

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}
