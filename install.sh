#!/bin/bash

set -ex
set -o nounset

# list of plugins to be installed
if [ -z "${ES_CLOUD_K8S_URL:-}" ] ; then
    ES_CLOUD_K8S_URL=io.fabric8:elasticsearch-cloud-kubernetes:${ES_CLOUD_K8S_VER}
fi
es_plugins=($ES_CLOUD_K8S_URL)

echo "ES plugins: ${es_plugins[@]}"
for es_plugin in ${es_plugins[@]}
do
  ${ES_HOME}/bin/elasticsearch-plugin install $es_plugin
done

mkdir /elasticsearch
chmod -R og+w ${ES_PATH_CONF} ${ES_HOME} ${HOME} /elasticsearch
chmod a+r /etc/sysconfig/elasticsearch
