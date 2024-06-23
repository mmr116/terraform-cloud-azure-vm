variable "resource_group_name" {
  description = "Name of the existing resource group"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
}

variable "admin_username_secret" {
  description = "Azure Key Vault secret name for the admin username"
  type        = string
}

variable "admin_password_secret" {
  description = "Azure Key Vault secret name for the admin password"
  type        = string
}

variable "vnet_name" {
  description = "Name of the existing virtual network"
  type        = string
}

variable "subnet_name" {
  description = "Name of the existing subnet"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Azure Key Vault"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
  default     = ["1", "2"]
}

variable "os_disk_size_gb" {
  description = "OS disk size in GB"
  type        = number
  default     = 30
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "StandardSSD_LRS"
}

variable "data_disk_size_gb" {
  description = "Data disk size in GB"
  type        = number
  default     = 50
}

variable "notification_email" {
  description = "Email address for auto-shutdown notifications"
  type        = string
  default     = "replace_by_required_email"
}

variable "tags" {
  description = "Tags to be applied to resources"
  type        = map(string)
}
