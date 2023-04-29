#!/bin/bash
oc project pasteboards

# not sure this is still necessary but it doesn't hurt
oc -n openshift tag registry.redhat.io/rhscl/nodejs-10-rhel7 nodejs:10
oc -n openshift tag registry.redhat.io/rhscl/mongodb-36-rhel7:latest mongodb:3.6

# We are just going to manually run through the steps outlined in the workshop to get things ready to showcase service mesh
# https://github.com/RedHatGov/service-mesh-workshop-dashboard/blob/main/workshop/content/lab1.3_deploymsa.md
oc new-app template-boards-fromsource \
  -p APPLICATION_NAME=boards \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git \
  -p GIT_BRANCH=workshop-stable \
  -p DATABASE_SERVICE_NAME=boards-mongodb \
  -p MONGODB_DATABASE=boardsDevelopment

oc new-app template-context-scraper-fromsource \
  -p APPLICATION_NAME=context-scraper \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git

oc new-app template-app-ui-fromsource \
  -p APPLICATION_NAME=app-ui \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git \
  -e FAKE_USER=true

oc new-app template-userprofile-build \
  -p APPLICATION_NAME=userprofile \
  -p APPLICATION_CODE_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git \
  -p APPLICATION_CODE_BRANCH=workshop-stable \
  -p APP_VERSION_TAG=1.0
oc start-build userprofile-1.0

oc get pods

oc create -f ./istio/gateway.yaml
oc create -f ./istio/virtual-services-all-v2.yaml
oc create -f ./istio/destrule-all.yaml

echo The istio ingress gateway is:
GATEWAY_URL=$(oc get route istio-ingressgateway -n istio-system --template='http://{{.spec.host}}')
echo $GATEWAY_URL

# load the main UI
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL; done

# load the user profile
for ((i=1;i<=100;i++)); do curl -s -o /dev/null $GATEWAY_URL/profile; done

oc describe cm kiali -n istio-system | grep excluded_workloads -A10
echo Please \'oc edit cm kiali -n istio-system\' to remove DeploymentConfigs and ReplicationControllers so that this legacy app will show up in Kiali