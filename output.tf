resource "local_file" "wireguard_client_config" {
  depends_on = [ibm_is_instance.wireguard_instance]
  content    = <<EOF
[Interface]
PrivateKey = ${var.client_private_key}
Address = 192.168.0.3/24

[Peer]
PublicKey = SERVER_PUBLIC_KEY_PLACEHOLDER
Endpoint = ${ibm_is_floating_ip.regional_fip.address}:51820
AllowedIPs = ${ibm_is_subnet.regional_z1_subnet.ipv4_cidr_block}, ${ibm_is_subnet.regional_z2_subnet.ipv4_cidr_block}, ${ibm_is_subnet.regional_z3_subnet.ipv4_cidr_block}, 166.8.0.0/14, 192.168.0.0/28, ${ibm_is_vpc.vpc.cse_source_addresses[0].address}, ${ibm_is_vpc.vpc.cse_source_addresses[1].address}, ${ibm_is_vpc.vpc.cse_source_addresses[2].address}

EOF

  filename = "${path.cwd}/${var.vpc_name}-${local.project}.conf"
}

output "wg_fip" {
  value = ibm_is_floating_ip.regional_fip.address
}

output "z1_instance_ip" {
  value = ibm_is_instance.z1_instance.primary_network_interface[0].primary_ipv4_address
}

output "z2_instance_ip" {
  value = ibm_is_instance.z2_instance.primary_network_interface[0].primary_ipv4_address
}

output "z3_instance_ip" {
  value = ibm_is_instance.z3_instance.primary_network_interface[0].primary_ipv4_address
}
