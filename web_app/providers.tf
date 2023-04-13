terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }
  }
}


##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  #For AWS CLI
  shared_credentials_files = ["/home/greg/.aws/credentials"]
  shared_config_files      = ["/home/greg/.aws/config"]
  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
  #region     = var.aws_region
}