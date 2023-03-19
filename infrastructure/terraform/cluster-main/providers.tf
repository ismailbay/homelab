# Proxmox Provider
# ---
# Initial Provider Configuration for Proxmox

terraform {

  required_version = ">= 0.13.0"

  required_providers {
    proxmox = {
      source  = "telmate/proxmox"
      version = "2.9.13"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.3.0"
    }
  }
}

variable "proxmox_api_url" {
  type = string
}

variable "proxmox_api_token_id" {
  type      = string
  sensitive = true
}

variable "proxmox_api_token_secret" {
  type      = string
  sensitive = true
}

provider "proxmox" {

  pm_api_url          = var.proxmox_api_url
  pm_api_token_id     = var.proxmox_api_token_id
  pm_api_token_secret = var.proxmox_api_token_secret

  pm_parallel = 3

  pm_log_enable = false
  pm_log_file   = "terraform-plugin-proxmox.log"
  pm_debug      = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }

  # (Optional) Skip TLS Verification
  pm_tls_insecure = true
}
