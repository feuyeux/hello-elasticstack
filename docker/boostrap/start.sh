#!/bin/bash
if [ ! -n "${NODE_NAME}" ]; then
	echo "ERROR: NODE_NAME, NODE_IP, CLUSTER_IPS cannot be null"
else
  sh ${HOME}/replace.sh
  export ES_JAVA_OPTS="-Xms${MEM} -Xmx${MEM}"
  sh ${ES_HOME}/bin/elasticsearch -Epath.conf=/config --silent & \
  ${KIBANA_HOME}/bin/kibana --config /config/kibana.yml --silent
fi

ulimit -a