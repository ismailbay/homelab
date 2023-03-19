resource "proxmox_vm_qemu" "proxmox_vm_master" {
  count = var.num_k3s_masters
  name  = "k3s-master-0${count.index + 1}"
  desc  = "K3S Master Node"
  vmid  = 200 + count.index + 1

  sockets = "1"
  cores   = 4
  memory  = 4096
  scsihw  = "virtio-scsi-pci"

  ipconfig0   = "gw=192.168.20.1,ip=${var.k3s_master_ip_addresses[count.index]}"
  target_node = "pve"
  onboot      = true
  oncreate    = true
  full_clone  = true
  clone       = var.k8s_source_template
  os_type     = "cloud-init"
  agent       = 1
  tablet      = false
  ciuser      = var.k3s_user
  sshkeys     = var.vm_ssh_keys

  disk {
    size    = "20G"
    type    = "scsi"
    storage = "local-zfs"
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }

  lifecycle {
    ignore_changes = [
      network, target_node
    ]
  }
}

resource "proxmox_vm_qemu" "proxmox_vm_worker" {
  count = var.num_k3s_workers
  name  = "k3s-worker-0${count.index + 1}"
  desc  = "K3S Worker Node"
  vmid  = 200 + var.num_k3s_masters + count.index + 1

  sockets = "1"
  cores   = 4
  memory  = 16384
  scsihw  = "virtio-scsi-pci"

  ipconfig0   = "gw=192.168.20.1,ip=${var.k3s_worker_ip_addresses[count.index]}"
  target_node = "pve"
  onboot      = true
  oncreate    = true
  full_clone  = true
  clone       = var.k8s_source_template
  os_type     = "cloud-init"
  agent       = 1
  tablet      = false
  ciuser      = var.k3s_user
  sshkeys     = var.vm_ssh_keys

  disk {
    size    = "30G"
    type    = "scsi"
    storage = "local-zfs"
    ssd     = 1
  }

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  serial {
    id   = 0
    type = "socket"
  }

  vga {
    type = "serial0"
  }

  lifecycle {
    ignore_changes = [
      network, target_node
    ]
  }
}

locals {
  k3s_rendered = templatefile("./templates/cluster-main.yaml.tftpl", {
    master_ips = proxmox_vm_qemu.proxmox_vm_master.*.default_ipv4_address
    worker_ips = proxmox_vm_qemu.proxmox_vm_worker.*.default_ipv4_address
  })
}

resource "local_file" "k3s_inventory" {
  content  = local.k3s_rendered
  filename = "../../ansible/inventory/cluster-main.yaml"
}
