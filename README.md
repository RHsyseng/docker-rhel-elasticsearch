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

## CentOS Container registry

Container images are available in [registry.centos.org](https://registry.centos.org/containers/).

Images are rebuilt automatically once a referenced repository is updated. See the [Container Index documentation](https://github.com/CentOS/container-index) for more information.

If the image tags also have to be changed, then the yaml configuration file in the container index repository must also be updated manually. 

An example can be found here [CentOS/container-index/pull/356](https://github.com/CentOS/container-index/pull/356).
