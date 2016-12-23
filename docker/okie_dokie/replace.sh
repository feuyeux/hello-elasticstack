#!/bin/bash
ES_CONF=${ES_HOME}/config/elasticsearch.yml
KB_CONF=${KIBANA_HOME}/config/kibana.yml
echo -e "REFRESHED AT ${REFRESHED_AT}"
if [ ! -n "${NODE_NAME}" ]; then
  echo "ERROR: NODE_NAME, NODE_IP, CLUSTER_IPS cannot be null"
else
  echo -e "NODE_NAME=${NODE_NAME}\nNODE_IP=${NODE_IP}\nCLUSTER_IPS=${CLUSTER_IPS}"
  sed -r -i "s/CLUSTER_NAME/${CLUSTER_NAME}/g" ${ES_CONF}
  sed -r -i "s/NODE_NAME/${NODE_NAME}/g" ${ES_CONF}
  sed -r -i "s/NODE_IP/${NODE_IP}/g" ${ES_CONF}
  sed -r -i "s/CLUSTER_IPS/${CLUSTER_IPS}/g" ${ES_CONF}
  sed -r -i "s/ZEN_NUM/${ZEN_NUM}/g" ${ES_CONF}
  sed -r -i "s/NODE_IP/${NODE_IP}/g" ${KB_CONF}
  sed -r -i "s/NODE_NAME/${NODE_NAME}/g" ${KB_CONF}
fi
echo -e "\nelasticsearch.yml:"
cat ${ES_CONF}
echo -e "\nkibana.yml:"
cat ${KB_CONF}
echo