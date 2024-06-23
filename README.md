# terraform-cloud-azure-vm

Deploying Azure VM using Terraform
This guide provides instructions on deploying an Azure virtual machine (VM) using Terraform, integrating with Azure Key Vault for sensitive data, and managing resource configurations efficiently.

Prerequisites
Before proceeding, ensure you have:

An Azure subscription with sufficient permissions to create resources.
Azure Key Vault setup with secrets for admin username and password.
Terraform installed on your local machine or build environment.
Files Included
main.tf: Defines Azure resources including VM, networking, security groups, backups, and shutdown schedules.
variables.tf: Contains variables used in main.tf for customization.
terraform.tfvars: Configuration file specifying values for variables in variables.tf.
Step-by-Step Deployment Process
Azure Resource Setup

Ensure the following resources are prepared or defined in your Azure environment:

Resource Group (resource_group_name)
Virtual Network (vnet_name)
Subnet (subnet_name)
Azure Key Vault (key_vault_id) with secrets for admin credentials.
Configure Terraform

Modify variables.tf to match your Azure environment specifics such as location, VM name, disk sizes, and email for notifications.

Deploy using Terraform

Run the following commands:

bash
Copy code
terraform init
terraform plan -out=tfplan
terraform apply tfplan
This sequence initializes Terraform, generates a deployment plan, and applies changes to Azure based on your configuration.

Accessing the VM

After deployment, access the VM using:

Username: Retrieved from Azure Key Vault.
Password: Retrieved from Azure Key Vault.
Managing Resources

Backups: Automatic VM backups are configured (azurerm_backup_policy_vm).
Shutdown Schedule: A daily shutdown schedule is configured (azurerm_dev_test_global_vm_shutdown_schedule).
Tags and Notifications

Tags (tags) are applied to all resources for cost tracking and management.
Notification emails are configured for shutdown alerts (notification_email).
Customization
Adjust VM specifications (size, image, disks) in main.tf as per workload requirements.
Modify variables in terraform.tfvars to reflect your specific environment and preferences.
Additional Notes
Ensure all dependencies and configurations (like network security groups, availability zones) are correctly set in Azure before deployment.
Regularly update and manage your Terraform configurations as your infrastructure evolves.
Troubleshooting
For issues or questions, refer to Terraform documentation or Azure support resources.

Resources
Terraform Documentation
Azure Key Vault Documentation
This ReadMe provides a structured approach to deploying and managing Azure VMs using Terraform, ensuring robustness and scalability in your cloud infrastructure setup. Adjust configurations and processes as necessary for your specific deployment scenarios.
