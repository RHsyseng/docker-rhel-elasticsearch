# Elasticsearch images for OpenShift

[![Build Status](https://travis-ci.org/ansibleplaybookbundle/es-apb.svg?branch=master)](https://travis-ci.org/RHsyseng/docker-rhel-elasticsearch)

This image includes the [elasticsearch-cloud-kubernetes](https://github.com/fabric8io/elasticsearch-cloud-kubernetes) plugin pre-installed along with
a default jvm configuration to get the Heap configuration from the cgroups.

 * [RHEL 7.3 image](./Dockerfile)
 * [CentOS 7 image](./Dockerfile.centos7)
 * Installation of Elasticsearch 5.5.2 is done through RPMs
 * The plugin is included directly as binary because it is not yet available on Maven Central

An example deployment file is also included:
```
$ oc create -f es-cluster-deployment.yml
statefulset "elasticsearch" created
service "elasticsearch" created
service "elasticsearch-cluster" created
imagestream "elasticsearch" created
serviceaccount "elasticsearch" created
```

The elasticsearch-cloud-kubernetes plugin requires the ServiceAccount to be allowed to get the endpoints:
```bash
$ oc adm policy add-role-to-user view -z elasticsearch
$ oc env statefulset/elasticsearch NAMESPACE=`oc project -q`
```
Now restart all Elasticsearch pods to apply the configuration change:
```bash
$ oc delete po -l app=elasticsearch
```

## Delete all resources
```bash
$ oc delete all,serviceaccounts -l app=elasticsearch
``
