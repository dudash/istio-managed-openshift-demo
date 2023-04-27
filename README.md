# istio-managed-openshift-demo
Demo of Istio Service Mesh on Managed OpenShift

## What is this all about?
Istio Service Mesh, OpenShift App Platform, Kubernetes, Microservices... More emerging tech and buzz words than you can shake a stick at!
## How can I deploiy it
I've done my best to automated the deployment of the required platform components (i.e. operators) as well as the demo application services. I've borrowed from some examples that other Red Hatters created, so thanks provided at the end of this readme.

### Login to your ROSA cluster (as an admin)
If you don't have one already check out this helpful post on how to create a ROSA cluster. ROSA is a managed OpenShift service from AWS.

### Bootstrap GitOps Capabilities
Run the following command to bootstrap our cluster with OpenShift GitOps - it'll be used later to [declare, pull, and reconsile](https://opengitops.dev/) our system services (platform components) and app workloads (apps).

```until oc apply -k bootstrap/overlays/dev/; do sleep 15; done```

### GitOps Installs
This will happen automatically - TBD more docs here

## Thanks
Thanks to [Christian Hernandez](https://github.com/christianh814) who's example I borrowed a lot from to get the bootstrap going in this repo.