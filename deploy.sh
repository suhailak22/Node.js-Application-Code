#!/bin/bash

# Initialize Terraform
terraform init

# Run Terraform plan (dry run)
terraform plan

# Prompt user for confirmation before applying
read -p "The Terraform plan looks good. Apply changes? (y/N): " answer

if [ "$answer" != "y" ]; then
  exit 1
fi

# Apply Terraform configuration
terraform apply
