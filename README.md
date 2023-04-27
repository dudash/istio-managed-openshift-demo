## What is this all about?
Want to try out OpenShift Service Mesh? Don't want the hassle of installing Kubernetes and all the platform layers that sit on top of it? Then this repo might be interesting for you...

OpenShift can be run as a managed service in your favorite public cloud. I put together this demo repo to showcase how to do that. I also wrote a little demo app to showcase some of the platform capabilities that OpenShift brings above and beyond Kubernetes. Service mesh, GitOps, aggregated logging (with Vector and Loki), Prometheus metrics, continuous code builds, automated containerization...

## How can I deploy it?
I've done my best to automate the deployment of the required platform components (i.e. operators) as well as the demo application services. I've borrowed from some examples that other Red Hatters created, so thanks provided at the end of this readme.

### Login to your ROSA or ARO cluster (as an admin)
If you don't have one already check out this helpful post on how to create a managed cluster.
* ROSA is a managed OpenShift service run by Amazon Web Services (and Red Hat)
    * [Setup instructions - COMING SOON]()
* ARO is a managed OpenShift service run by Microsoft Azure (and Red Hat)
    * [Setup instructions - COMING SOON]()
* RHPDS is a Red Hat and partners private service run by Red Hat
    * [Setup instructions](./.docs/setup-rhpds.md)

### Bootstrap GitOps capabilities
Run the following command to bootstrap our cluster with OpenShift GitOps - it'll be used later to [declare, pull, and reconcile](https://opengitops.dev/) our system services (platform components) and app workloads (apps). Make sure to login as an admin first.

```until oc apply -k bootstrap/overlays/dev/; do sleep 15; done```

It's going to spit out a bunch of error looking output - which is OK, probably - our bootstrap isn't super clean and ordered so that's why we have it wrapped in `until` loop. It should eventually finish and tell you things are `created` and `configured`. An example bootstrap output [looks like this](./.docs/bootstrap-output.txt). Once it finishes, we still need to wait until ArgoCD installs our system services (:stopwatch: ~10 min in my testing).

### Choose your own adventure
There are a few different paths to get started running the demo app and seeing some cool things in action. Choose your path from the options below:
1) TBD
2) TBD
3) TBD
4) TBD
5) TBD

## Thanks to
Thanks to [Christian Hernandez](https://github.com/christianh814) who's [example](https://github.com/christianh814/ocp-sm-ar/tree/main) I borrowed a lot from to get the bootstrap going in this repo.

## About the code / software architecture
COMING SOON

## Other references
* [OpenShift Service Mesh Workshop Code](https://github.com/RedHatGov/service-mesh-workshop-code)
* [Red Hat Developer](https://developers.redhat.com/)
* [OpenShift Docs](https://docs.openshift.com/container-platform/4.12/service_mesh/v2x/ossm-about.html)