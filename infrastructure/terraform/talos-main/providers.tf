provider "proxmox" {
  pm_parallel         = 3
  pm_tls_insecure     = true
  pm_api_url          = var.pm_api_url
  pm_api_token_id     = data.sops_file.secrets.data["pm_api_token_id"]
  pm_api_token_secret = data.sops_file.secrets.data["pm_api_token_secret"]
  pm_timeout          = 600
  pm_log_enable       = false
  pm_debug            = false
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

provider "sops" {}
