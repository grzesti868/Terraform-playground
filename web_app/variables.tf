# variable "aws_access_key" {
#   type        = string
#   description = "AWS Access Key"
#   sensitive   = true
# }
# variable "aws_secret_key" {
#   type        = string
#   description = "AWS Secret Key"
#   sensitive   = true
# }
# variable "aws_region" {
#   type        = string
#   description = "AWS Region to use for resources"
#   default     = "default value"
# }
variable "vpc_cidr_block" {
  type        = map(string)
  description = "Base CIDR Block for VPC"
}
variable "vpc_subnets_cidr_block" {
  type        = list(string)
  description = "CIDR Block for Subnets in VPC"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}
variable "vpc_subnet_count" {
  type        = map(number)
  description = "Number of subnets"
}
variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS hostnames in VPC"
  default     = true
}
variable "map_public_ip_on_launch" {
  type        = bool
  description = "Map a public IP address for subnet instances"
  default     = true
}
variable "instance_type" {
  type        = map(string)
  description = "Type for EC2 instance"
}
variable "company" {
  type        = string
  description = "Company name"
  default     = "Silesian University"
}
variable "project" {
  type        = string
  description = "Poject name"
}
variable "billing_code" {
  type        = string
  description = "Billing code for resource tagging"

}
variable "count_instances" {
  type        = map(number)
  description = "Number of instances to create"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for resources"
  default     = "thesis"
}