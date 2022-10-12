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
terraform apply -var-file="linux.tfvars" -auto-approve

# Destroy when finished
terraform destroy -var-file="linux.tfvars" -auto-approve
```

## Switch to Windows workspace and spin up environment
```bash
terraform workspace list
terraform workspace select Windows

# Creating a PEM key
ssh-keygen -t rsa -m PEM

terraform init
terraform plan -var-file="windows.tfvars"
terraform apply -var-file="windows.tfvars" -auto-approve

# Destroy when finished
terraform destroy -var-file="windows.tfvars" -auto-approve
```

Note:
It was quite challenging to create a Windows admin user via the user-data due to the Windows password policy.
A quite complex password was required. Example: `^^T3$t_123_!`
