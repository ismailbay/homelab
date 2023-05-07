terraform {
  cloud {
    organization = "ismailbay"

    workspaces {
      name = "talos-main"
    }
  }
}
