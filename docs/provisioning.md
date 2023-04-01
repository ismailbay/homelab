## Terraform

Per Terraform provisioniere ich derzeit die Kubernetes VMs und die Domain über Cloudflare.
In Zukunft möchte ich noch die Verwaltung von TrueNAS Storage über Terraform abwickeln.

## Ansible

Ansible kommt bei der Provisionierung von k3s zum Einsatz. Dank der hervorragenden Collection von [xanmanning.k3s](https://github.com/PyratLabs/ansible-role-k3s.git) ist die Installation von k3s ein Kinderspiel.
