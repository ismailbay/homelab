variable "pm_api_url" {
  default = "https://192.168.20.201:8006/api2/json"
}

variable "common" {
  type = map(string)
  default = {
    vm_template = "talos"
    ciuser      = "ismail"
    cores       = 4
  }
}

variable "nodes" {
  type = map(map(string))
  default = {
    k8s-01 = {
      id          = 210
      macaddr     = "02:DE:4D:48:28:10"
      ip4_addr    = "192.168.20.210"
      pv_zfs      = "local-zfs"
      memory      = 16384
      disk0       = "32G"
      disk1       = "250G"
      target_node = "pve"
    },
    k8s-02 = {
      id          = 211
      macaddr     = "02:DE:4D:48:28:11"
      ip4_addr    = "192.168.20.211"
      pv_zfs      = "local-zfs"
      memory      = 16384
      disk0       = "32G"
      disk1       = "250G"
      target_node = "pve"
    },
    k8s-03 = {
      id          = 212
      macaddr     = "02:DE:4D:48:28:12"
      ip4_addr    = "192.168.20.212"
      pv_zfs      = "local-zfs"
      memory      = 16384
      disk0       = "32G"
      disk1       = "250G"
      target_node = "pve"
    }
  }
}
