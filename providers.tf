terraform {
  required_version = ">= 0.13"
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.12.0"
    }
  }
}

provider "ibm" {
  region     = var.region
  generation = 2
}