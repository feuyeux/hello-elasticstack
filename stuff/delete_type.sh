# https://www.elastic.co/guide/en/elasticsearch/reference/current/docs-delete-by-query.html
INDEX_NAME=$1
TYPE_NAME=$2

if [ $# -lt 2 ]; then
    echo "Usage: delete_type.sh index_name type_name"
    exit 1
fi

curl -XPOST 'es1.alibaba.net:9200/'${INDEX_NAME}'/_delete_by_query?pretty' -d'
{
    "query": {
        "match": {
            "_type": "'${TYPE_NAME}'"
        }
    }
}'
