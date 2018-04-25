#!/bin/bash

set -ex
set -o nounset

es_plugins=("")

echo "ES plugins: ${es_plugins[@]}"
for es_plugin in ${es_plugins[@]}
do
  ${ES_HOME}/bin/elasticsearch-plugin install $es_plugin
done

mkdir /elasticsearch
chmod -R a+rX ${ES_PATH_CONF} /elasticsearch /etc/sysconfig/elasticsearch
chmod -R a+wx /elasticsearch
