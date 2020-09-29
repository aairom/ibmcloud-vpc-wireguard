
resource "ibm_is_security_group" "wireguard_security_group" {
  name = "wireguard-z1-sg"
  vpc  = ibm_is_vpc.vpc.id
}

# resource "ibm_is_security_group" "open_security_group" {
#   name = "open-z1-sg"
#   vpc  = ibm_is_vpc.vpc.id
# }

# resource "ibm_is_security_group_rule" "inbound_sg_rule" {
#   group     = ibm_is_security_group.open_security_group.id
#   direction = "inbound"
#   remote    = "0.0.0.0/0"
# }

# resource "ibm_is_security_group_rule" "outbound_sg_rule" {
#   group     = ibm_is_security_group.open_security_group.id
#   direction = "outbound"
#   remote    = "0.0.0.0/0"
# }

resource "ibm_is_security_group_rule" "home_ssh_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = var.remote_ssh_ip
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "wg_icmp" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

resource "ibm_is_security_group_rule" "z1_inbound_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z1_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "z2_inbound_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z2_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "z3_inbound_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z3_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "inbound_wireguard_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = 51820
    port_max = 51820
  }
}

resource "ibm_is_security_group_rule" "outbound_wireguard_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
  udp {
    port_min = 51820
    port_max = 51820
  }
}

resource "ibm_is_security_group_rule" "outbound_sg_rule" {
  group     = ibm_is_security_group.wireguard_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}

resource "ibm_is_security_group" "service_instance_security_group" {
  name = "service-instance-sg"
  vpc  = ibm_is_vpc.vpc.id
}

resource "ibm_is_security_group_rule" "instance_ssh" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  tcp {
    port_min = 22
    port_max = 22
  }
}

resource "ibm_is_security_group_rule" "instance_icmp" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "inbound"
  remote    = "0.0.0.0/0"
  icmp {
    type = 8
  }
}

resource "ibm_is_security_group_rule" "z1_subnet_rule" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z1_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "z2_subnet_sg_rule" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z2_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "z3_subnet_sg_rule" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "inbound"
  remote    = ibm_is_subnet.regional_z3_subnet.ipv4_cidr_block
}

resource "ibm_is_security_group_rule" "instance_outbound_sg_rule" {
  group     = ibm_is_security_group.service_instance_security_group.id
  direction = "outbound"
  remote    = "0.0.0.0/0"
}