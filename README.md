# Elasticsearch images for OpenShift

This image includes the [elasticsearch-cloud-kubernetes](https://github.com/fabric8io/elasticsearch-cloud-kubernetes) plugin pre-installed along with
a default jvm configuration to get the Heap configuration from the cgroups.

* Installation of Elasticsearch 6.2.1 is done through RPMs
* The plugin is included directly as binary because it is not yet available on Maven Central
