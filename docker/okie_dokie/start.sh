#!/bin/bash
if [ ! -n "${NODE_NAME}" ]; then
	echo "ERROR: NODE_NAME, NODE_IP, CLUSTER_IPS cannot be null"
else
  sh ${HOME}/replace.sh
  export ES_JAVA_OPTS="-Xms${MEM} -Xmx${MEM}"
  sh ${ES_HOME}/bin/elasticsearch --quiet & ${KIBANA_HOME}/bin/kibana --silent
fi