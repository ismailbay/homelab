Der Fokus liegt auf Einfachheit. Da ich im Bereich Netzwerk noch ein Anfänger bin, ist die Segmentierung und die Sicherheit noch ziemlich schlecht.

## Topologie

192.168.20.1/24 Netzwerk überträgt bereits die VLAN Id 20. Der Netgear Switch ist aber noch nicht für tagging/untagging konfiguriert.

```
     +------------+                                                          
     |            |                                                          
     |  Internet  |                                                          
     |            |                                                          
     +------|-----+                                                            
            |                        +------------------------------------------+
            |                        |                                          |
   +--------|--------+               |             Linksys Router + Switch      |
   |  Magenta Modem  |               |                                          |
   |   Bridge Mode   |               +--------+-----++-----++-----++-----++-----+
   +--------+-----+--+                        | WAN ||Port1||Port2||Port3||Port4|
               |Port1|                        +--|--++-----++-----++-----++-----+
               +--|--+               192.168.1.1 |      |                        
                  |                              |      |                    
                  |                              |      |                        
                  |                              |      |                        
                  -------------------------------|      |  192.168.20.1/24                      
                                                        |            
                                                        |                        
                              ---------------------------                        
                              |                                                  
                              |       +-----------------------------------+        
                              |       |                    Netgear GS105  |        
                              |       |                           Switch  |        
                              |       +-+-----++-----++-----++-----++-----+        
                              |         |Port1||Port2||Port3||Port4||Port5|        
                              |         +-----++-----++-----++-----++-----+         
                              |           |       |      |      |      |
                              |           |       |      |      |      |
                              -------------       |      |      |      --------- PC 
                                                  |      |      |      
                                                  |      |      -------- on-demand Geräte wie Drucker      
                                                  |      |         
                                                  |       -------- PVE Mini Node      
                       Proxmox Main Node ----------                192.168.20.100
                       192.168.20.201
```

## IP Adressen

| IP                 | Machine/VM    |
| ------------------ | ------------- |
| 192.168.20.100     | PVE Mini      |
| 192.168.20.200     | NetGear       |
| 192.168.20.201     | PVE Main      |
| 192.168.20.202     | ?             |
| 192.168.20.203     | TrueNAS VM    |
| 192.168.20.210     | k3s-0 |
| 192.168.20.211     | k3s-worker-01 |
| 192.168.20.212     | k3s-worker-02 |
| 192.168.20.220     | k3s VirtualIP |
| 192.168.20.221     | traefik LB    |
| 192.168.20.231-240 | MetalLB range |
