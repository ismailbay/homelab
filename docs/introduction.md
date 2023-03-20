## Warum?

In der Arbeit fehlt oft die Möglichkeit, neue Technologien auszuprobieren. Entweder fehlt mir die Zeit dafür oder ich kann die Technologie nicht ohne Risiko auf andere Komponenten in der Infrastruktur anwenden.

Ein typisches Beispiel ist der Einsatz eines neuen Ingress Controllers oder von Kernkomponenten von Kubernetes wie cert-manager, Kyverno, Descheduler, usw.

Deshalb wollte ich zuhause einen eigenen Kubernetes-Cluster aufbauen und diese Technologien ohne Risiko testen.

Leider (oder zum Glück?) zeigt das neu erworbene Wissen, wie wenig ich eigentlich weiß und wie viel ich noch zu entdecken und zu lernen habe. Während ich mich tiefer ins DevOps/GitOps-Rabbit-Hole begebe, werde ich versuchen, so viel wie möglich hier zu dokumentieren. Diese Seiten sind in erster Linie für mich gedacht. Daher wird die Qualität oft nicht gut genug sein.

⚠️ Das ist ein **Lernprojekt für mich**. Bitte beachte, dass vieles hier inkorrekt oder lückenhaft sein kann und wird.

## Die ersten Experimente

In 2022 habe ich bereits mit dem Projekt begonnen und erste Erfahrungen mit Proxmox gesammelt.

Für meine ersten Experimente wollte ich möglichst wenig Geld ausgeben. Auf Willhaben habe ich folgende Komponenten gekauft:

| Teil                   |                                                      |      € |
| ---------------------- | ---------------------------------------------------- | -----: |
| Netgear GS105e ProSAFE | 5-Port: Managed Switch, derzeit unmanaged            |     10 |
| Fujitso Esprimo Q520   | ein Mini PC mit i5-4570T 2c/4t, 4GB DDR3, 128 GB SSD |     50 |
| Ram Upgrade            | 2 x 8 GB Module                                      |     35 |
|                        | **Summe**                                            | **95** |

Ich war positiv überrascht, wie viel Compute Power ein so günstiger Mini-PC liefern kann. Es war problemlos möglich, ein k3s-Cluster aus einem Master und drei Workers mit 6-8 typischen Homelab-Services zu betreiben.

## Der langfristige Plan

* Infrastructure as Code 
* GitOps
* Hands-On Erfahrung mit [CNCF](https://www.cncf.io) Graduated und Incubated Projekten sammeln
