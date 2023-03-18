Der Fokus liegt auf Einfachheit. Da ich im Networkbereich ein Anfänger bin, ist die Segmentierung und die Sicherheit noch ziemlich schlecht.

## Netzwerk
---
192.168.20.1/24 Netzwerk überträgt bereits die VLAN Id 20. Der Netgear Switch ist aber noch nicht für tagging/untagging konfiguriert.

```
     +------------+                                                                            
     |            |                                                                            
     |  Internet  |                                                                            
     |            |                                                                            
     +------|-----+                                                                              
            |                                          +------------------------------------------+
            |                                          |                                          |
   +--------|--------+                                 |             Linksys Router + Switch      |
   |  Magenta Modem  |                                 |                                          |
   |   Bridge Mode   |                                 +--------+-----++-----++-----++-----++-----+
   +--------+-----+--+                                          | WAN ||Port1||Port2||Port3||Port4|
               |Port1|                                          +--|--++-----++-----++-----++-----+
               +--|--+                                 192.168.1.1 |      |                        
                  |                                                |      |                    
                  |                                                |      |                        
                  |                                                |      |                        
                  -------------------------------------------------|      |  192.168.20.1/24                      
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
                                         Proxmox Main Node ----------                192.168.1.101
                                         192.168.1.201
```
