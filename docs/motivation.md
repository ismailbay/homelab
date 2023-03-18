## Warum?
---

In der Arbeit fehlt oft die Möglichkeit neue Technologien zu probieren. Entweder fehlt mir die Zeit dafür oder ich kann die Technologie nicht ohne Risiko auf andere Komponenten in der Infrastruktur einsetzen. 

Ein typisches Beispiel ist der Einsatz von einem neuen Ingress Controller bzw. von Kubernetes Kernkomponenten wie [cert-manager](http://cert-manager.io/), [kyverno](https://kyverno.io), [descheduler](https://github.com/kubernetes-sigs/descheduler/), usw.. 

Daher wollte ich zuhause einen eigenen Kubernetes Cluster aufbauen und diese Technologien ohne Gefahr einsetzen. 

Leider (oder zum Glück?) zeigt das neu Gelernte auf, wie wenig man eigentlich weiß und noch zu entdecken und zu lernen hat. Während ich das DevOps/GitOps Rabbit Hole absteige, werde ich versuchen, so viel wie möglich hier zu dokumentieren. Diese Seiten sind in erster Linie für mich gedacht. Daher wird die Qualität vermutlich einiges zu wünschen übriglassen. 

⚠️ Das ist ein **Lernprojekt für mich**. Bitte beachte, dass vieles hier inkorrekt/lückenhaft sein kann und wird.

## Die ersten Experimente
---

In 2022 habe ich bereits mit dem Projekt begonnen und die ersten Erfahrungen mit [Proxmox](https://www.proxmox.com/en/) gesammelt.

Für die ersten Experimente wollte ich möglichst wenig Geld ausgeben. Auf [willhaben](https://willhaben.at) habe ich folgende Komponenten gekauft:

| Teil |  | € |
|----------|-------------|------:|
| Netgear GS105e ProSAFE | 5-Port: Managed Switch, derzeit unmanaged | 10 |
| Fujitso Esprimo Q520 | ein Mini PC mit i5-4570T 2c/4t, 4GB DDR3, 128 GB SSD | 50 |
| Ram Upgrade | 2 x 8 GB Module | 35 |
|  | **Summe** | **95** |

Ich war positiv überrascht, wie viel Compute Power ein so billiger MiniPC liefern kann. Es war problemlos möglich, ein k3s Cluster aus einem Master, drei Workers mit 6-8 typischen Homelab Services zu betreiben.

## Der langfristige Plan
---

* Infrastructure as Code 
* GitOps
* Hands-On Erfahrung mit [CNCF](https://www.cncf.io) Graduated und Incubated Projekten sammeln
