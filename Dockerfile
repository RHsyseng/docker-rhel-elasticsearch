FROM rhel7:7.3

MAINTAINER OpenShift Development <dev@lists.openshift.redhat.com>

EXPOSE 9200
EXPOSE 9300
USER 0

ARG ES_VERSION=5.5.2

ENV ES_CLOUD_K8S_VER=${ES_VERSION} \
    ES_PATH_CONF=/etc/elasticsearch \
    ES_HOME=/usr/share/elasticsearch \
    ES_VER=${ES_VERSION} \
    HOME=/opt/app-root/src \
    JAVA_VER=1.8.0 \
    NODE_QUORUM=1 \
    ES_CLUSTER_SERVICE=elasticsearch-cluster \
    LOG_LEVEL=info


LABEL io.k8s.description="Elasticsearch container" \
      io.k8s.display-name="Elasticsearch ${ES_VER}" \
      io.openshift.expose-services="9200:https, 9300:https" \
      io.openshift.tags="elasticsearch" \
      architecture=x86_64 \
      name="openshift3/elasticsearch"

COPY elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
# install the RPMs in a separate step so it can be cached
RUN rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch
RUN yum install -y --setopt=tsflags=nodocs \
                java-${JAVA_VER}-openjdk-headless \
                elasticsearch-${ES_VER} && \
    yum clean all

COPY install.sh ${HOME}/
COPY config/* ${ES_PATH_CONF}/
RUN ${HOME}/install.sh && \
  rm ${HOME}/install.sh

WORKDIR ${HOME}
USER 999
CMD ["sh", "-c", "${ES_HOME}/bin/elasticsearch -Epath.conf=${ES_PATH_CONF}"]
