terraform {
  cloud {
    organization = "ismailbay"

    workspaces {
      name = "pve-provisioner"
    }
  }
} 