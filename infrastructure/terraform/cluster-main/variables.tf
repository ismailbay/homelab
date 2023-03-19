variable "vm_ssh_keys" {
  description = "ssh keys used in VMs"
  type        = string
}

variable "num_k3s_masters" {
  default = 1
}

variable "k3s_master_ip_addresses" {
  description = "List of IP addresses for master node(s)"
  type        = list(string)
  default     = ["192.168.20.210/24", "192.168.20.211/24", "192.168.20.213/24"]
}

variable "num_k3s_workers" {
  default = 2
}

variable "k3s_worker_ip_addresses" {
  description = "List of IP addresses for master node(s)"
  type        = list(string)
  default     = ["192.168.20.214/24", "192.168.20.215/24", "192.168.20.216/24"]
}

variable "k8s_source_template" {
  default = "ubuntu-cloud"
}

variable "k3s_user" {
  default = "ismail"
}