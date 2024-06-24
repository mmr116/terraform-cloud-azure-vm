# Azure Virtual Machine (VM) Deployment using Terraform Cloud

This repository contains Terraform configuration files for deploying an Azure VM using Terraform Cloud. 

# Key Features

# Pre-requisites or Assumptions:

**Azure Resources**

An Azure subscription with Service Principal which has 'contributor' level access to an existing Azure Resource Group. Azure VNET and subnet information are also required. Additionally, an Azure Key Vault (key_vault_id) is required which will store VM's user credentials (username and password) as Key Vault secrets.

**Terraform Cloud Configuration**

Make sure you have Terraform Cloud Account (https://app.terraform.io).

Additional structure in the Terraform Cloud:

Terraform Cloud Organization: Create or use an existing organization within your Terraform Cloud account.

Terraform Cloud Project: Create or use an existing project within your Terraform Cloud account.

Workspace: Create a workspace within the project for the Azure VM deployment, which will be linked to the related GitHub repository.

**Terraform Cloud Integration with GitHub**

The Terraform workspace is integrated with this GitHub repository using Terraform Version Control Workflow (VCS-driven workflow). This integration ensures that whenever code is committed to the repository, a Terraform run is triggered automatically. Additional configurations can be done to ensure if Terraform plan and Terraform apply will run automatically or with operator's approval.

Here’s how the integration works:

- Authentication: The Terraform workspace is authenticated with the GitHub repository through OAuth or a personal access token. This allows Terraform Cloud to monitor the repository for changes. (https://developer.hashicorp.com/terraform/tutorials/cloud/github-oauth)

- Terraform Run within Terraform Workspace (Workspaces -> Runs)

- Terraform Plan: During the run, Terraform will generate an execution plan to show what changes will be made.

- Terraform Apply: After reviewing the plan, the changes can be applied to deploy the resources.

- Auto Apply

Sets this workspace to automatically apply changes for successful runs. If disabled (below options), runs require operator approval for executing the Terraform plan and Terraform apply. (Workspaces -> Settings -> General)

- Auto-apply API, CLI, & VCS runs (Automatically apply changes when a terraform plan is successfull)
- Auto-apply run triggers (Run Triggers create new plan)

# Deployment Step

**Secret Management**

The Azure Service Principal information required for deployment, such as the client ID, client secret, subscription ID, and tenant ID, are stored as sensitive variables in Terraform Cloud Workspace. As mentioned above, Azure VM Admin Username and Password are stored in an Azure Key Vault secret.

ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID These values must be stored in Terraform Cloud workspace as sensitive variables to ensure they are kept secure.

# Clone Repository

Clone this repository to your local machine:

git clone <<repository-url>>

# Review and Modify Configuration

Review the configuration files (main.tf, variables.tf) to ensure they match your requirements. Adjust the configuration as necessary.

# Commit Changes to GitHub

git add .

git status

git commit -m "Your commit message"

git push origin main

# Terraform Cloud Run

- Terraform Plan: Terraform Cloud will automatically create an execution plan showing what changes will be made to your infrastructure.

- Terraform Apply: After reviewing and confirming the plan in the Terraform Cloud interface, the changes will be applied to deploy the resources.


# Verify Deployment

After a successful deployment, verify that the Azure VM is created as expected.

**Accessing the VM**

After deployment, access the VM using:

Username: Retrieved from Azure Key Vau
Password: Retrieved from Azure Key Vault.

# Cleanup

To clean up the deployed resources, use Terraform to destroy them. This can be triggered from the Terraform Cloud interface. (Workspace -> Destruction and Deletion)



















