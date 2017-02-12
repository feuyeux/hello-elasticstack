#!/bin/bash
ES_CONF=/config/elasticsearch.yml
KB_CONF=/config/kibana.yml

if [ ! -n "${NODE_NAME}" ]; then
  echo "ERROR: NODE_NAME, NODE_IP, CLUSTER_IPS cannot be null"
else
  #echo -e "NODE_NAME=${NODE_NAME}\nNODE_IP=${NODE_IP}\nCLUSTER_IPS=${CLUSTER_IPS}"
  sed -r -i "s/CLUSTER_NAME/${CLUSTER_NAME}/g" ${ES_CONF}
  sed -r -i "s/NODE_NAME/${NODE_NAME}/g" ${ES_CONF}
  sed -r -i "s/NODE_IP/${NODE_IP}/g" ${ES_CONF}
  sed -r -i "s/CLUSTER_IPS/${CLUSTER_IPS}/g" ${ES_CONF}
  sed -r -i "s/ZEN_NUM/${ZEN_NUM}/g" ${ES_CONF}
  sed -r -i "s/NODE_IP/${NODE_IP}/g" ${KB_CONF}
  sed -r -i "s/NODE_NAME/${NODE_NAME}/g" ${KB_CONF}
fi
echo