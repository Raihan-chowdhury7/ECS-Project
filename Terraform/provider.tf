terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.15.0"
    }
  }

  backend "s3" {
    bucket         = "my-terraform-config-bucket-raihan"
    key            = "state/devops-lab/terraform.tfstate"
    region         = "eu-west-2"
    encrypt        = true
    dynamodb_table = "terraform-locks" 
  }

}

provider "aws" {
  region = "eu-west-2"
}
