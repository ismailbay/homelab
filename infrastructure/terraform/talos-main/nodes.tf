resource "proxmox_vm_qemu" "talos_vm" {
  for_each = var.nodes

  name        = each.key
  target_node = each.value.target_node
  onboot      = true
  agent       = 0
  clone       = var.common.vm_template
  vmid        = each.value.id
  cores       = var.common.cores
  memory      = each.value.memory
  bootdisk    = "scsi0"
  scsihw      = "virtio-scsi-pci"
  os_type     = "cloud-init"
  ipconfig0   = "gw=192.168.20.1,ip=${each.value.ip4_addr}/24"
  ciuser      = var.common.ciuser
  cipassword  = data.sops_file.secrets.data["cipassword"]
  sshkeys     = data.sops_file.secrets.data["ssh_key"]

  network {
    model   = "virtio"
    macaddr = each.value.macaddr
    bridge  = "vmbr0"
  }

  disk {
    type    = "scsi"
    storage = "local-zfs"
    size    = each.value.disk0
    format  = "raw"
    ssd     = 1
    discard = "on"
  }

  disk {
    type    = "scsi"
    storage = each.value.pv_zfs
    size    = each.value.disk1
    format  = "raw"
    ssd     = 1
    discard = "on"
  }

  serial {
    id   = 0
    type = "socket"
  }
}
