provider "azurerm" {
  features {}
}

data "azurerm_key_vault_secret" "admin_username" {
  name         = var.admin_username_secret
  key_vault_id = var.key_vault_id
}

data "azurerm_key_vault_secret" "admin_password" {
  name         = var.admin_password_secret
  key_vault_id = var.key_vault_id
}

data "azurerm_virtual_network" "existing_vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group_name
}

data "azurerm_subnet" "existing_subnet" {
  name                 = var.subnet_name
  virtual_network_name = data.azurerm_virtual_network.existing_vnet.name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_public_ip" "main" {
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  tags                = var.tags
}

resource "azurerm_network_interface" "main" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.main.id
  }

  tags = var.tags
}

resource "azurerm_network_security_group" "main" {
  name                = "${var.vm_name}-nsg"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-SSH"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = var.tags
}

resource "azurerm_network_interface_security_group_association" "main" {
  network_interface_id      = azurerm_network_interface.main.id
  network_security_group_id = azurerm_network_security_group.main.id
}

resource "azurerm_linux_virtual_machine" "main" {
  name                  = var.vm_name
  resource_group_name   = var.resource_group_name
  location              = var.location
  size                  = "Standard_D2s_v3"
  admin_username        = data.azurerm_key_vault_secret.admin_username.value
  admin_password        = data.azurerm_key_vault_secret.admin_password.value

  network_interface_ids = [
    azurerm_network_interface.main.id,
  ]

  availability_zone     = var.availability_zones[0] # Using the first availability zone for simplicity
  computer_name         = var.vm_name
  disable_password_authentication = false

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.os_disk_size_gb
    delete_with_vm       = true
  }

  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.9"
    version   = "latest"
  }

  data_disk {
    name                 = "${var.vm_name}-datadisk1"
    lun                  = 0
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.data_disk_size_gb
  }

  data_disk {
    name                 = "${var.vm_name}-datadisk2"
    lun                  = 1
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_type
    disk_size_gb         = var.data_disk_size_gb
  }

  boot_diagnostics {
    enabled = false
  }

  os_profile_linux_config {
    disable_password_authentication = false
    patch_settings {
      patch_mode = "AutomaticByPlatform"
    }
  }

  tags = var.tags
}

resource "azurerm_dev_test_global_vm_shutdown_schedule" "main" {
  name                 = "${var.vm_name}-shutdown"
  location             = var.location
  resource_group_name  = var.resource_group_name
  notification_settings {
    status        = "Enabled"
    email_address = var.notification_email
  }
  daily_recurrence_time = "0200"
  time_zone_id          = "UTC"
  enabled               = true
  tags                  = var.tags
}

resource "azurerm_backup_policy_vm" "main" {
  name                = "${var.vm_name}-backup-policy"
  resource_group_name = var.resource_group_name
  location            = var.location

  retention_daily {
    count = 30
  }

  tags = var.tags
}

resource "azurerm_backup_protected_vm" "main" {
  resource_group_name      = var.resource_group_name
  backup_policy_id         = azurerm_backup_policy_vm.main.id
  source_virtual_machine_id = azurerm_linux_virtual_machine.main.id

  tags = var.tags
}
