# base block to define which terraform providers to use
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS provider
provider aws {
  region = var.default-region
  profile = "default"
}
