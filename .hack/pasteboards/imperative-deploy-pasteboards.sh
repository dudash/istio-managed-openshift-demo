#!/bin/bash
oc project pasteboards

# not sure this is still necessary but it doesn't hurt
oc -n openshift tag registry.redhat.io/rhscl/nodejs-10-rhel7 nodejs:10

# We are just going to manually run through the steps outlined in the workshop to get things ready to showcase service mesh
# https://github.com/RedHatGov/service-mesh-workshop-dashboard/blob/main/workshop/content/lab1.3_deploymsa.md
oc new-app -f ./config/app/boards-fromsource.yaml \
  -p APPLICATION_NAME=boards \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git \
  -p GIT_BRANCH=workshop-stable \
  -p DATABASE_SERVICE_NAME=boards-mongodb \
  -p MONGODB_DATABASE=boardsDevelopment

oc new-app -f ./config/app/context-scraper-fromsource.yaml \
  -p APPLICATION_NAME=context-scraper \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git

oc new-app -f ./config/app/app-ui-fromsource.yaml \
  -p APPLICATION_NAME=app-ui \
  -p NODEJS_VERSION_TAG=16-ubi8 \
  -p GIT_BRANCH=workshop-stable \
  -p GIT_URI=https://github.com/RedHatGov/service-mesh-workshop-code.git \
  -e FAKE_USER=true

oc get pods

oc create -f ./istio/gateway.yaml
GATEWAY_URL=$(oc get route istio-ingressgateway -n istio-system --template='http://{{.spec.host}}')
echo $GATEWAY_URL
