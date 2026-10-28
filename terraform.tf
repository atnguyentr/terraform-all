terraform {
  cloud {
    organization = "GamoroLearn"

    workspaces {
      name = "tf-all"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region              = "ap-southeast-1"
  allowed_account_ids = ["258675982519"]
}
