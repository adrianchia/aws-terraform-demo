# AWS Terraform
A workshop to learn AWS and Terraform

## Prerequisites
- AWS Account
- aws cli (install via pip, homebrew, etc)
- terraform cli

### Notable Terraform commands to remember
- `terraform init` to initialize project
- `terraform init -upgrade` to upgrade terraform
- `terraform plan` to let terraform display what would be added/modified/removed without actually doing so
- `terraform apply` to make the change, note that terraform will ask for confirmation if you really want to make the change.
- `terraform apply -auto-approve` to make the change and confirm with no acknowledgement. (only use this if you are absolutely sure)
- `terraform destroy` to remove all changes done so far.

## Getting started

1. git clone this repository and `cd` into the destination folder
2. run `terraform init`, make sure you are able to see the following messages

```
Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
```

### Note 1: There are several ways to configure the AWS providers
- using hardcoded values **[Not recommended]**
- using variables from .tfvars
- specify profile from preconfigured aws cli
- using environment variables

for more details see https://registry.terraform.io/providers/hashicorp/aws/latest/docs

3. the most important file is the `main.tf` file, which tells terraform which providers to use, and provides configurations to the providers, here we uses the `hashicorp/aws` provider and configure the aws provider to use us-east-1 as the default region and uses the default profile which I configured earlier.

### Note 2
- Terraform supports AWS cost estimation via Terraform Team & Governance package (paid package) in the Terraform Cloud edition, Terraform enterprise supports such functionality as well which requires AWS credentials to support cost estimation
