resource "ibm_is_public_gateway" "z1_public_gateway" {
  name           = "${var.vpc_name}-z1-pgw-${local.project}"
  resource_group = data.ibm_resource_group.rg.id
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[0]
  tags           = [data.ibm_is_zones.regional_zones.zones[0], "ryantiffany", local.project]
}

resource "ibm_is_public_gateway" "z2_public_gateway" {
  name           = "${var.vpc_name}-z2-pgw-${local.project}"
  resource_group = data.ibm_resource_group.rg.id
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[1]
  tags           = [data.ibm_is_zones.regional_zones.zones[1], "ryantiffany", local.project]
}

resource "ibm_is_public_gateway" "z3_public_gateway" {
  name           = "${var.vpc_name}-z3-pgw-${local.project}"
  resource_group = data.ibm_resource_group.rg.id
  vpc            = ibm_is_vpc.vpc.id
  zone           = data.ibm_is_zones.regional_zones.zones[2]
  tags           = [data.ibm_is_zones.regional_zones.zones[2], "ryantiffany", local.project]
}

resource "ibm_is_subnet" "regional_z1_subnet" {
  name                     = "${var.vpc_name}-subnet-z1-${local.project}"
  resource_group           = data.ibm_resource_group.rg.id
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[0]
  public_gateway           = ibm_is_public_gateway.z1_public_gateway.id
  total_ipv4_address_count = 32

}

resource "ibm_is_subnet" "regional_z2_subnet" {
  name                     = "${var.vpc_name}-subnet-z2-${local.project}"
  resource_group           = data.ibm_resource_group.rg.id
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[1]
  public_gateway           = ibm_is_public_gateway.z2_public_gateway.id
  total_ipv4_address_count = 32
}

resource "ibm_is_subnet" "regional_z3_subnet" {
  name                     = "${var.vpc_name}-subnet-z3-${local.project}"
  resource_group           = data.ibm_resource_group.rg.id
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = data.ibm_is_zones.regional_zones.zones[2]
  public_gateway           = ibm_is_public_gateway.z3_public_gateway.id
  total_ipv4_address_count = 32
}

resource "ibm_is_floating_ip" "regional_fip" {
  depends_on = [ibm_is_instance.wireguard_instance]
  name       = "${var.vpc_name}-wg-fip-${local.project}"
  target     = ibm_is_instance.wireguard_instance.primary_network_interface[0].id
}