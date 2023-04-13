## Terraform

Per Terraform provisioniere ich derzeit die Kubernetes VMs und die Domain über Cloudflare.
In Zukunft möchte ich noch die Verwaltung von TrueNAS Storage über Terraform abwickeln.

> Der Telmate Proxmox Provider kann leider keine PCI passthrough konfigurieren. Nach der initialen Erstellung der VMs muss einer der Worker Nodes die iGPU per PCI-passthrough zugewiesen bekommen. [Ein gutes Tutorial findet man hier.](https://3os.org/infrastructure/proxmox/gpu-passthrough/igpu-split-passthrough/)

Danach wird [node-feature-discovery](https://kubernetes-sigs.github.io/node-feature-discovery) dieses Feature entdecken und den jeweiligen Node um das Label `"feature.node.kubernetes.io/custom-intel-gpu": "true"` erweitern.

## Ansible

Ansible kommt bei der Provisionierung von k3s zum Einsatz. Dank der hervorragenden Collection von [xanmanning.k3s](https://github.com/PyratLabs/ansible-role-k3s.git) ist die Installation von k3s ein Kinderspiel.
