
> Flux CD is a GitOps operator for Kubernetes that works by synchronizing the state of manifests in a Git repository to the designated setting for a cluster.

### Monorepo

* **clusters** definiert die Umgebungen
* **infrastructure** stellt für den k8s-Betrieb notwendige Komponenten bereit
* **repositories** beinhaltet die Artefakt Repos wie Helm, Git, ...
* **apps** können für jede Umgebung angepasst werden. 

  ```
   ├── apps
   │   ├── base
   │   │   └── default
   │   ├── production
   │   │   └── kustomization.yaml
   │   └── staging
   │       └── kustomization.yaml
   ├── clusters
   │   ├── production
   │   └── staging
   │       ├── cluster-apps.yaml
   │       ├── cluster-infrastructure.yaml
   │       ├── flux-system
   │       └── vars
   └── infrastructure
      ├── configs
      │   ├── cluster-issuer.yaml
      │   ├── kustomization.yaml
      │   └── secret.sops.yaml
      ├── controllers
      │   ├── cert-manager
      │   ├── kube-system
      │   ├── monitoring
      │   └── networking
      └── sources
         ├── git
         ├── helm
         └── kustomization.yaml
  ```

### Bootstrap

Vor dem Bootstapping muss noch ein [GitHub Token für Flux](https://fluxcd.io/flux/cmd/flux_bootstrap_github/) mit Berechtitungen zum Pushen angelegt werden. 

Danach noch diese Variablen zu `.config.env` hinzufügen:

  ```
  export GITHUB_USER="ismailbay"
  export GITHUB_REPO="homelab"
  export GITHUB_TOKEN="github_pat_superSecretToken123"
  ```

Das Taskfile stellt ein paar convenience Befehle bereit:

1. `task flux:verify`  
   prüft die Voraussetzungen  
2. `task flux:install`  
   installiert Flux im Kubernetes und verwendet die GitHub Variablen für die Einrichtung
1. `task flux:reconcile`  
   startet eine Reconcilation aus dem Git Repository

### Dependencies

  ```
  cluster-apps: 
  dependsOn:
      infrastructure-configs: 
      dependsOn:
          infrastructure-controllers
          dependsOn:
              infrastructure-sources
  ```
