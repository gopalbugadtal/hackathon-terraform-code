terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }

  backend "s3" {
    bucket = "artificial-instinct-bucket"
    key    = "terraform-state-file/terraform.tfstate"
    region = "ap-south-1"
    encrypt = true
  }
}

provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Name = "Artificial-Instinct"
    }
  }
}
