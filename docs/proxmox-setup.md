Bevor wir die VMs per Terraform provisionieren, müssen noch einige Schritte manuell erledigt werden.

## Helper Scripts

[Proxmox Helper Scripts](https://tteck.github.io/Proxmox/) sind nützliche Tools, die man nach jeder Proxmox-Installation ausführen sollte:

  ```bash
  # ! wie immer soll man die Skripte vor der Ausführung anschauen und verifizieren
  
  # repos and updates
  bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/post-pve-install.sh)"
  # alte kernels bereinigen
  bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/kernel-clean.sh)"
  # edge kernel
  bash -c "$(wget -qLO - https://github.com/tteck/Proxmox/raw/main/misc/edge-kernel.sh)"
  ```

## Powertop

[Powertop](https://wiki.ubuntuusers.de/PowerTOP/) hilft dabei, dass der Server tiefere 
Stromsparzustände erreichen kann und somit auch weniger Wärme produziert.

Per SSH am Proxmox Server anmelden:

   ```bash
   apt install powertop

   cat << EOF | tee /etc/systemd/system/powertop.service
   [Unit]
   Description=PowerTOP auto tune

   [Service]
   Type=oneshot
   Environment="TERM=dumb"
   RemainAfterExit=true
   ExecStart=/usr/sbin/powertop --auto-tune

   [Install]
   WantedBy=multi-user.target
   EOF

   systemctl daemon-reload
   systemctl enable powertop.service
   systemctl start powertop.service

   ```

## SATA Passthrough

Da ich Proxmox auf zwei NVMe-Disks als ZFS Raid1 installiert habe, kann ich den gesamten 
SATA-Controller an die TrueNAS-VM weiterreichen.

### IOMMU aktivieren

Die Datei `/etc/default/grub` editieren:

  ```
  ...
  GRUB_CMDLINE_LINUX_DEFAULT="quiet intel_iommu=on"
  ...
  ```

Die Datei `/etc/kernel/cmdline` editieren:

  ```
  root=ZFS=rpool/ROOT/pve-1 boot=zfs quite intel_iommu=on
  ```

Danach müssen noch zwei Befehle ausgeführt werden:

  ```bash
  update-grub
  proxmox-boot-tool refresh
  reboot
  ```

Ob alles erfolgreich war, kann man nach einem SSH-Login mit `dmesg | grep 'IOMMU enabled'` überprüfen.

### AHCI blacklisten

ℹ️ Falls neue HDD-Festplatten in Betrieb genommen werden und kein anderer Rechner zur Verfügung steht, 
sollten diese vor diesem Schritt initialisiert werden. Siehe [nächsten Schritt TrueNAS Scale](#disk-burnin)

Damit werden die SATA Disks nicht mehr am Proxmox angebunden und können gänzlich von TrueNAS verwaltet werden. 

  ```bash
  echo 'blacklist ahci' > /etc/modprobe.d/ahci-blacklist.conf
  update-initramfs -u && reboot
  ```

Nach dem Reboot per SSH einloggen und überprüfen:

  ```bash
  # lsmod sollte ahci nicht mehr auflisten
  lsmod | grep ahci  
  # lsblk sollte keine SATA disks mehr auflisten
  lsblk
  ```

## TrueNAS Scale

### Disk Burnin

Bevor neue HDD-Festplatten in Betrieb genommen werden, ist es ratsam, diese "einzubrennen". 
Die Idee dahinter ist, dass eine eingebrannte, unter Stress getestete HDD höchstwahrscheinlich 
langfristig auch ohne Fehler laufen wird. Dieser Prozess dauert sehr lange. Grob kann man mit 
einem Tag pro 2 TB Kapazität rechnen.

Zum Klonen des Repositorys:

  1. repo clonen: https://github.com/Spearfoot/disk-burnin-and-testing
  2. im checkout Verzeichnis:
  ```bash
  # am besten nach dem SSH Login tmux bzw. screen starten,
  # damit man die Session ohne SSH Logout wieder deattachen kann
  ./disk-burnin.sh -f sdX # per lsblk die richtigen device mappings zeigen
  ```
  3. täglich einloggen, Session wieder attachen und die Konsolenausgabe nach Fehlern durchsuchen

### VM

  1. eine VM mit 4 Cores und 1 GB RAM pro TB an Speicherkapazität erstellen
  > Ich habe nur 8 GB RAM vergeben, da ich erstens nur 12 TB Poolsize habe und zweitens keine VMs und oft 
  gelesene Dateien am TrueNAS ablegen werde. 
  2. Machine type auf `q35` ändern, als Bios `UEFI` auswählen
  3. SATA Controller als PCI Device hinzufügen
  4. unter Optionen Start/Shutdown Order auf 1 und Startup Delay auf 120 setzen
  5. nach dem Boot schnell ins BIOS gehen und Secure Boot deaktivieren

TrueNAS konfigurieren, Pool erstellen, ...

### Powertop

Mit Powertop unter TrueNAS werden die Stromsparzustände der Festplatten aktiviert.

In TrueNas under "System Settings -> Advanced" 
  * add "Init/Shutdown Script" of type "Command" 
  * als Command `powertop --auto-tune` eintragen und unter "When" PostInit auswählen

### Potenzielle Verbesserungen

Die TrueNAS Konfiguration werde ich in Zukunft auch auf Terraform migrieren. 

## Cloudinit Template

Das Cloudinit Template wird als Basis für weitere VMs dienen. 

⚠️ Laut [Dokumentation](https://cloudinit.readthedocs.io/en/latest/reference/examples.html#install-arbitrary-packages) 
können Pakete per Konfiguration beim ersten Boot installiert werden. Dieser Ansatz wäre sauberer und 
würde einige Befehle unten obsolet machen.

  ```bash
  sudo apt update -y && sudo apt install libguestfs-tools -y
  
  cd /tmp
  wget http://cloud-images.ubuntu.com/releases/22.10/release/ubuntu-22.10-server-cloudimg-amd64.img
  virt-customize --install 'cloud-init,qemu-guest-agent,curl,wget' -a ubuntu-22.10-server-cloudimg-amd64.img
  
  qm create 9000 --memory 2048 --cores 4 --name ubuntu-cloud --net0 virtio,bridge=vmbr0
  qm importdisk 9000 ubuntu-22.10-server-cloudimg-amd64.img  local-lvm
  qm set 9000 --scsihw virtio-scsi-pci --scsi0 local-lvm:vm-9000-disk-0
  qm resize 9000 scsi0 20G
  qm set 9000 --ide2 local-lvm:cloudinit
  qm set 9000 --boot c --bootdisk scsi0
  qm set 9000 --serial0 socket --vga serial0
  qm set 9000 --agent 1
  qm set 9000 --tablet 0
  # cloudinit user
  qm set 9000 --ciuser ismail
  # copy your public key to proxmox host, .e.g under /tmp
  # on your laptop, pc, etc.: 
  # scp ~/.ssh/id_ed25519.pub root@192.168.20.201:/tmp/
  qm set 9000 --sshkey /tmp/id_ed25519.pub
  qm set 9000 --ipconfig0 ip=dhcp
  
  # final step, create the template
  qm template 9000
  ```
