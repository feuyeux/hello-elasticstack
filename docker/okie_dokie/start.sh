#!/bin/bash
if [ ! -n "${NODE_NAME}" ]; then
	echo "ERROR: NODE_NAME, NODE_IP, CLUSTER_IPS cannot be null"
else
  sh ${HOME}/replace.sh
  export ES_JAVA_OPTS="-Xms${MEM} -Xmx${MEM}"
  sh ${ES_HOME}/bin/elasticsearch -Epath.conf=${ES_HOME}/config2 --silent & \
  ${KIBANA_HOME}/bin/kibana --config ${KIBANA_HOME}/config2/kibana.yml --silent
fi
ulimit -a