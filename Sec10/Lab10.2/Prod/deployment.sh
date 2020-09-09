export ARM_CLIENT_ID=$(client_id)
export ARM_CLIENT_SECRET=$(client_secret)
export ARM_SUBSCRIPTION_ID=$(subscription_id)
export ARM_TENANT_ID=$(tenant_id)
terraform init -backend-config=backend.tfvars
terraform plan
terraform apply -auto-approve
unset ARM_CLIENT_ID
unset ARM_CLIENT_SECRET
unset ARM_SUBSCRIPTION_ID
unset ARM_TENANT_ID