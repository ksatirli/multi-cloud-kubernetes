variable "tfe_workspaces_prefix" {
  type        = string
  description = "Prefix for TFE Workspaces."
  default     = "multi-cloud-k8s"
}

variable "aws_region" {
  type        = string
  description = "This is the AWS region."
  default     = "us-west-1" # N. California, US
}

variable "subnet_az" {
  type        = list(string)
  description = "List of strings of Availability Zone suffixes."

  default = [
    "a",
    "c",
  ]
}
