resource_group_name    = "test-resource-group01"
location               = "East US"
vm_name                = "testvm-011"
admin_username_secret  = "vmAdminUsername"
admin_password_secret  = "vmAdminPassword"
vnet_name              = "myVnet"
subnet_name            = "mySubnet"
key_vault_id           = "/subscriptions/<subscription-id>/resourceGroups/myResourceGroup/providers/Microsoft.KeyVault/vaults/myKeyVault"
availability_zones     = ["1", "2"]
os_disk_size_gb        = 30
os_disk_type           = "StandardSSD_LRS"
data_disk_size_gb      = 50
notification_email     = "replace_by_your_email"
tags = {
  cost_center = "12345"
  owner       = "owner_name"
  department  = "IT"
}
