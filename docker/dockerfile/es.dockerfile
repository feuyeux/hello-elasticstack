FROM feuyeux/java8-nodejs7-alpine
MAINTAINER Eric Han <feuyeux.gmail.com>

ENV STACK_VERSION=5.1.1 PLUGIN_VERSION=5.0.1 HOME=/home/admin
ENV ES_HOME=${HOME}/elasticsearch-${STACK_VERSION} KIBANA_HOME=${HOME}/kibana-${STACK_VERSION}-linux-x86_64 ES_TAR=elasticsearch-${STACK_VERSION}.tar.gz KB_TAR=kibana-${STACK_VERSION}-linux-x86_64.tar.gz REFRESHED_AT=2016-12-10

RUN adduser -D -h /bin/sh admin
WORKDIR ${HOME}
COPY okie_dokie/${ES_TAR} okie_dokie/${KB_TAR} okie_dokie/*.sh config/*.yml es_plugins/*.zip ${HOME}/

RUN tar -zxf ${ES_TAR} && rm -rf ${ES_TAR} && \
tar -zxf ${KB_TAR} &&  rm -rf ${KB_TAR} && \
## config
#mv elasticsearch.yml ${ES_HOME}/config/ && \
#mv kibana.yml ${KIBANA_HOME}/config/ && \
## plugin
#mkdir -p ${ES_HOME}/plugins/ik/ && mkdir -p ${ES_HOME}/plugins/pinyin && \
#unzip -q elasticsearch-analysis-ik-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/ik/ && \
#unzip -q elasticsearch-analysis-pinyin-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/pinyin/ && rm -f *.zip \
rm -f ${KIBANA_HOME}/node/bin/node ${KIBANA_HOME}/node/bin/npm && \
ln -s $(which node) ${KIBANA_HOME}/node/bin/node && ln -s $(which npm) ${KIBANA_HOME}/node/bin/npm && \
mkdir /data && chown -R admin:admin /data ${HOME} && chmod +x ${HOME}/*.sh

USER admin
VOLUME ["/data"]
#CMD sh /home/admin/start.sh
CMD sh ${ES_HOME}/bin/elasticsearch --quiet & ${KIBANA_HOME}/bin/kibana --silent
EXPOSE 9200 9300 5601