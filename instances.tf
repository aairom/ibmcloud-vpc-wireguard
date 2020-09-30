resource "ibm_is_instance" "wireguard_instance" {
  name    = "${var.vpc_name}-wg-${local.project}"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = ibm_is_subnet.regional_z1_subnet.id
    security_groups = [ibm_is_security_group.wireguard_security_group.id]
  }

  resource_group = data.ibm_resource_group.rg.id
  tags           = [var.region, local.project]

  vpc       = ibm_is_vpc.vpc.id
  zone      = data.ibm_is_zones.regional_zones.zones[0]
  keys      = [data.ibm_is_ssh_key.ssh_key.id]
  user_data = templatefile("${path.module}/installer.sh", { client_public_key = var.client_public_key, client_preshared_key = var.client_preshared_key })
}

resource "ibm_is_instance" "z1_instance" {
  name    = "${var.vpc_name}-z1-${local.project}"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = ibm_is_subnet.regional_z1_subnet.id
    security_groups = [ibm_is_security_group.service_instance_security_group.id]
  }

  resource_group = data.ibm_resource_group.rg.id
  tags           = [var.region, local.project]

  vpc  = ibm_is_vpc.vpc.id
  zone = data.ibm_is_zones.regional_zones.zones[0]
  keys = [data.ibm_is_ssh_key.ssh_key.id]
}

resource "ibm_is_instance" "z2_instance" {
  name    = "${var.vpc_name}-z2-${local.project}"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = ibm_is_subnet.regional_z2_subnet.id
    security_groups = [ibm_is_security_group.service_instance_security_group.id]
  }

  resource_group = data.ibm_resource_group.rg.id
  tags           = [var.region, local.project]

  vpc  = ibm_is_vpc.vpc.id
  zone = data.ibm_is_zones.regional_zones.zones[1]
  keys = [data.ibm_is_ssh_key.ssh_key.id]
}

resource "ibm_is_instance" "z3_instance" {
  name    = "${var.vpc_name}-z3-${local.project}"
  image   = data.ibm_is_image.default.id
  profile = var.default_instance_profile

  primary_network_interface {
    subnet          = ibm_is_subnet.regional_z3_subnet.id
    security_groups = [ibm_is_security_group.service_instance_security_group.id]
  }

  resource_group = data.ibm_resource_group.rg.id
  tags           = [var.region, local.project]

  vpc  = ibm_is_vpc.vpc.id
  zone = data.ibm_is_zones.regional_zones.zones[2]
  keys = [data.ibm_is_ssh_key.ssh_key.id]
}