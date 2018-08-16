# Elasticsearch images for OpenShift

[![Build Status](https://travis-ci.org/RHsyseng/docker-rhel-elasticsearch.svg?branch=5.x)](https://travis-ci.org/RHsyseng/docker-rhel-elasticsearch)

This image includes a default jvm configuration to get the Heap configuration from the cgroups.

 * [RHEL 7.3 image](./Dockerfile)
 * [CentOS 7 image](./Dockerfile.centos7)
 * Installation of Elasticsearch 5.6.10 is done through RPMs
 * The plugin is included directly as binary because it is not yet available on Maven Central

## OpenShift deployment

There are two deployment files
 * `es-cluster-deployment.yml` - it provides a basic deployment with 3 Elasticsearch nodes
 * `es-cluster-deployment-roles.yml` - it provides a deployment with dedicated Elasticsearch nodes (master and data)

## Delete all resources
```
$ oc delete all,configmap,imagestream -l app=elasticsearch
```

## Publish Docker Images

Docker images are available in [registry.centos.org](https://registry.centos.org/).
The images are rebuild automatically see the registry documentation. However, the image tags has
to be updated manually. For example see [CentOS/container-index/pull/356](https://github.com/CentOS/container-index/pull/356).
