variable "region" {
  type        = string
  description = "The region where the VPC resources will be deployed."
  default     = ""
}

variable "ssh_key" {
  type        = string
  description = "The SSH Key that will be added to the compute instances in the region."
  default     = ""
}

variable "default_instance_profile" {
  type        = string
  description = "Instance size for compute nodes."
  default     = "bx2-2x8"
}

variable "os_image" {
  type        = string
  description = "OS Image to use for VPC instances. Default is currently Ubuntu 18."
  default     = "ibm-ubuntu-18-04-1-minimal-amd64-2"
}

variable "resource_group" {
  type        = string
  description = "Resource group where resources will be deployed."
  default     = ""
}

variable "remote_ssh_ip" {
  type        = string
  description = "IP of your local machine"
  default     = ""
}

variable "client_public_key" {
  type        = string
  default     = ""
  description = "Wireguard client public key"
}

variable "vpc_name" {
  type        = string
  description = "Name of vpc and related resources"
  default     = "wgtest"
}

variable "client_private_key" {
  type        = string
  description = "Private WG key used to populate local wg file."
  default     = ""
}

variable "client_preshared_key" {
  type        = string
  description = "Client WG Preshared Key."
  default     = ""
}