# AWS Terraform Provisioning
Creating Linux and Windows EC2 Instances using Terraform

## Create separate workspaces to ensure different state files**
```bash
terraform workspace list
terraform workspace new Linux
terraform workspace new Windows
```

## Switch to Linux workspace and spin up environment
```bash
terraform workspace list
terraform workspace select Linux

terraform init
terraform plan -var-file="linux.tfvars"
terraform apply -var-file="linux.tfvars"

# Destroy when finished
terraform destroy -var-file="linux.tfvars"
```

## Switch to Windows workspace and spin up environment
```bash
terraform workspace list
terraform workspace select Windows

terraform init
terraform plan -var-file="windows.tfvars"
terraform apply -var-file="windows.tfvars"

# Destroy when finished
terraform destroy -var-file="windows.tfvars"
```