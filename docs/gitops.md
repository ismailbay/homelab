
> Flux CD is a GitOps operator for Kubernetes that works by synchronizing the state of manifests in a Git repository to the designated setting for a cluster.

### Monorepo

* **bootstrap** wird als in einem Cluster eingespielt
* **cluster** definiert die Umgebungen
* **repositories** beinhaltet die Artefakt Repos wie Helm, Git, ...
* 

  ```
  ├── apps
  │   ├── base
  │   ├── production 
  │   └── staging
  |── bootstrap
  ├── infrastructure
  │   ├── configs
  │   └── controllers
  └── clusters
      ├── production    (pve-main, ismailbay.dev)
      └── staging       (pve-mini, ibay.dev)
  ```

