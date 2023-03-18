## Netzwerk

* Linksys WRT3200ACM mit [OpenWrt](https://openwrt.org)
* Netgear GS105e

## Proxmox Main Node

Dieser Server hostet alle Kubernetes VMs und eine VM für TrueNAS Scale.

| Teil                                  | Modell                    | €             |
|---------------------------------------|---------------------------|--------------:|
| Mainboard                             | Fujitsu D3644-B           | 200           |
| Cpu                                   | i3-8100 (used)            | 45            |
| Ram                                   | 2 x 32 GB ECC DDR4-3200   | 280           |
| Boot Disk + VMs                       | 2 x 1 TB Samsung 980 NVMe | 160           |
| NAS                                   | 3 x 6TB Seagate IronWolf  | 420           |
| Gehäuse                               | RackMount 4HE (used)      | 30            |
| Netzteil                              | Pico 150W + Leicke 160W   | 40            |
| Kleinteile                            | Kabel, etc.               | 60            |
|                                       | **Summe**                 | **ca. 1250**  |

## Proxmox Mini Node

[Fujitsu Esprimo Q520](motivation?id=die-ersten-experimente) dient nun als Staging K3s Cluster. 

## Ausbau in Zukunft

* UniFi Switch Pro 24 PoE (Layer 3)
* UniFi Access Points
* Mainboard und CPU Upgrade auf Workstation, besser noch Server Level