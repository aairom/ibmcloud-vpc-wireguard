
data "ibm_resource_group" "rg" {
  name = var.resource_group
}

data "ibm_is_zones" "regional_zones" {
  region = var.region
}

data "ibm_is_ssh_key" "ssh_key" {
  name = var.ssh_key
}

data "ibm_is_image" "default" {
  name = var.os_image
}