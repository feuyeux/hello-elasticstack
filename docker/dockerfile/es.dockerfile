FROM feuyeux/java8-nodejs7-alpine
MAINTAINER Eric Han <feuyeux.gmail.com>

ENV STACK_VERSION=5.2.2 PLUGIN_VERSION=5.2.2 HOME=/home/admin
ENV ES_HOME=${HOME}/elasticsearch-${STACK_VERSION} KIBANA_HOME=${HOME}/kibana-${STACK_VERSION}-linux-x86_64 ES_TAR=elasticsearch-${STACK_VERSION}.tar.gz KB_TAR=kibana-${STACK_VERSION}-linux-x86_64.tar.gz REFRESHED_AT=2017-03-19

RUN adduser -D -h /bin/sh admin
WORKDIR ${HOME}

## install es and kb
COPY okie_dokie/${ES_TAR} okie_dokie/${KB_TAR} okie_dokie/es_plugins/*.zip ${HOME}/
RUN tar -zxf ${ES_TAR} && tar -zxf ${KB_TAR} &&  \

## install plugin
    mkdir -p ${ES_HOME}/plugins/ik/ && mkdir -p ${ES_HOME}/plugins/pinyin && \
    unzip -q elasticsearch-analysis-ik-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/ik/ && \
    unzip -q elasticsearch-analysis-pinyin-${PLUGIN_VERSION}.zip -d ${ES_HOME}/plugins/pinyin/ && \
    rm -f ${KIBANA_HOME}/node/bin/node ${KIBANA_HOME}/node/bin/npm && \
    ln -s $(which node) ${KIBANA_HOME}/node/bin/node && ln -s $(which npm) ${KIBANA_HOME}/node/bin/npm && \

## install xpack plugin
    ${ES_HOME}/bin/elasticsearch-plugin install file://${HOME}/x-pack-${STACK_VERSION}.zip && \
    ${KIBANA_HOME}/bin/kibana-plugin install file://${HOME}/x-pack-${STACK_VERSION}.zip && \

## clean
    rm -rf ${ES_TAR} && rm -rf ${KB_TAR} && rm -rf *.zip

COPY boostrap/*.sh ${HOME}/

## config for pam_limits.so(Pluggable Authentication Modules) in linux-pam
RUN mkdir /etc/security/ /etc/pam.d/ && touch /etc/security/limits.conf && touch /etc/pam.d/login && \
    echo "admin soft memlock unlimited" > /etc/security/limits.conf && \
    echo "admin hard memlock unlimited" >> /etc/security/limits.conf && \
    echo "session required pam_limits.so" > /etc/pam.d/login && \

## privilege
    mkdir /config /data && chown -R admin:admin /config /data ${HOME} && chmod +x ${HOME}/*.sh

USER admin
VOLUME ["/config","/data"]
CMD sh /home/admin/start.sh
EXPOSE 9200 9300 5601