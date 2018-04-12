#!/bin/bash

count=0
max_count=20
replicas=$(oc get sts elasticsearch -o jsonpath='{.spec.replicas}')
ready_replicas=0

while [[ $count -lt $max_count && ( -z $replicas || ! $replicas -eq $ready_replicas ) ]]
do
  sleep 2
  ready_replicas=$(oc get sts elasticsearch -o jsonpath='{.status.readyReplicas}')
  count=$((count+1))
  echo "Retry $count out of $max_count"
done

if [ $max_count == $count ]; then
  echo "Timeout waiting for Elasticsearch replicas to be ready $ready_replicas / $replicas"
  exit 1
fi

echo Ready replicas is equals to the expected replicas $ready_replicas / $replicas

ES_SVC=$(oc get svc elasticsearch -o jsonpath='{.spec.clusterIP}')

count=0
NODES=0

while [[ $count -lt $max_count && ! $NODES -eq $replicas ]]; do
  sleep 2
  NODES=$(curl -s http://$ES_SVC:9200/_cat/nodes | wc -l)
  count=$((count+1))
  echo "Retry $count out of $max_count"
done

if [ ! $NODES -eq $replicas ]; then
  echo "Expecting $replicas nodes in the cluster, got $NODES"
  exit 1
fi

echo "Successfully checked cluster size is equals to the number of replicas $replicas"
