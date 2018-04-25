# Elasticsearch images for OpenShift

[![Build Status](https://travis-ci.org/RHsyseng/docker-rhel-elasticsearch.svg?branch=master)](https://travis-ci.org/RHsyseng/docker-rhel-elasticsearch)

This image includes a default jvm configuration to get the Heap configuration from the cgroups.

 * [RHEL 7.3 image](./Dockerfile)
 * [CentOS 7 image](./Dockerfile.centos7)
 * Installation of Elasticsearch 6.2.2 is done through RPMs
 * The plugin is included directly as binary because it is not yet available on Maven Central

An example deployment file is also included:
```
$ oc create -f es-cluster-deployment.yml
statefulset "elasticsearch" created
service "elasticsearch" created
service "elasticsearch-cluster" created
imagestream "elasticsearch" created
```

## Delete all resources
```bash
$ oc delete all -l app=elasticsearch
```
