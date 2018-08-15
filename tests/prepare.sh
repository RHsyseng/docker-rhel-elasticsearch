#!/bin/bash

export PROJECT_NAME=docker-rhel-elasticsearch
export VERSION=5.6.10

function prepare() {
  sudo docker cp $(docker create docker.io/openshift/origin:$OPENSHIFT_VERSION):/bin/oc /usr/local/bin/oc
  oc cluster up --version=$OPENSHIFT_VERSION
  oc login -u system:admin
  export REGISTRY_URL=$(oc get svc -n default docker-registry -o jsonpath='{.spec.clusterIP}:{.spec.ports[0].port}')
  oc login -u developer -p developer
  oc new-project $PROJECT_NAME
}

function build() {
  docker build -f Dockerfile.centos7 . -t $REGISTRY_URL/$PROJECT_NAME/elasticsearch:$VERSION
}

function deploy() {
  docker login -u `oc whoami` -p `oc whoami -t` $REGISTRY_URL
  docker push $REGISTRY_URL/$PROJECT_NAME/elasticsearch:$VERSION
  oc create -f es-cluster-deployment.yml
  oc policy add-role-to-user view -z elasticsearch
}

prepare

build

deploy
