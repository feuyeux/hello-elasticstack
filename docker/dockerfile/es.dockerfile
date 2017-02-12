FROM feuyeux/java8-nodejs7-alpine
MAINTAINER Eric Han <feuyeux.gmail.com>

ENV STACK_VERSION=5.2.0 PLUGIN_VERSION=5.2.0 HOME=/home/admin
ENV ES_HOME=${HOME}/elasticsearch-${STACK_VERSION} KIBANA_HOME=${HOME}/kibana-${STACK_VERSION}-linux-x86_64 ES_TAR=elasticsearch-${STACK_VERSION}.tar.gz KB_TAR=kibana-${STACK_VERSION}-linux-x86_64.tar.gz REFRESHED_AT=2016-12-10

RUN adduser -D -h /bin/sh admin
WORKDIR ${HOME}
COPY okie_dokie/${ES_TAR} okie_dokie/${KB_TAR} es_plugins/*.zip ${HOME}/
RUN tar -zxf ${ES_TAR} && rm -rf ${ES_TAR} && \
tar -zxf ${KB_TAR} &&  rm -rf ${KB_TAR} && \

## plugin
mkdir -p ${ES_HOME}/plugins/ik/ && mkdir -p ${ES_HOME}/plugins/pinyin && \
unzip -q elasticsearch-analysis-ik-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/ik/ && \
unzip -q elasticsearch-analysis-pinyin-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/pinyin/ && \
rm -f ${KIBANA_HOME}/node/bin/node ${KIBANA_HOME}/node/bin/npm && \
ln -s $(which node) ${KIBANA_HOME}/node/bin/node && ln -s $(which npm) ${KIBANA_HOME}/node/bin/npm && \

## xpack
#${ES_HOME}/bin/elasticsearch-plugin install --batch x-pack && \
#${KIBANA_HOME}/bin/kibana-plugin install x-pack && \

${ES_HOME}/bin/elasticsearch-plugin install file://${HOME}/x-pack-${STACK_VERSION}_es.zip && \
${KIBANA_HOME}/bin/kibana-plugin install file://${HOME}/x-pack-${STACK_VERSION}_kb.zip && rm -rf *.zip

COPY okie_dokie/*.sh config/*.yml ${HOME}/
## config
RUN mkdir ${ES_HOME}/config2/ ${KIBANA_HOME}/config2/ && \
cp -r ${ES_HOME}/config/* ${ES_HOME}/config2/ && \
cp -r ${KIBANA_HOME}/config/* ${KIBANA_HOME}/config2/ && \
mv elasticsearch.yml ${ES_HOME}/config2/ && \
mv kibana.yml ${KIBANA_HOME}/config2/ && \

mkdir /etc/security/ && touch /etc/security/limits.conf && \
echo "admin soft memlock unlimited" > /etc/security/limits.conf && \
echo "admin hard memlock unlimited" >> /etc/security/limits.conf && \
sh -c "ulimit -l unlimited" && \

## privilege
mkdir /data && chown -R admin:admin /data ${HOME} && chmod +x ${HOME}/*.sh

USER admin
VOLUME ["/data"]
CMD sh /home/admin/start.sh
EXPOSE 9200 9300 5601