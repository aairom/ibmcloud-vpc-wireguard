locals {
  project = terraform.workspace
}


resource "ibm_is_vpc" "vpc" {
  name           = "${var.vpc_name}-${local.project}"
  resource_group = data.ibm_resource_group.rg.id
  tags           = [var.region]
}