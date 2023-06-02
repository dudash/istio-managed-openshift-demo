# Bootstrap
This is where we define Kustomize-able resources that will bootstrap the cluster with minimal required capabilities.

Bootstap has a 'base' and uses 'overlays' that modify the common base.
An 'overlay' is just another kustomization, referring to the 'base', and referring to patches to apply to that base.

## Current List
* OpenShift GitOps
    * ArgoCD AppProjects
    * ArgoCD ApplicationSets
