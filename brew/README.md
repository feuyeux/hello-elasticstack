filebeat -c ~/vangogh/filebeat.yml -configtest -v
filebeat -c ~/vangogh/vanGogh.fb.yml -v

> https://github.com/logstash-plugins/logstash-patterns-core/blob/master/patterns/grok-patterns

logstash -f ~/vangogh/vanGogh.ls.simple.conf --config.reload.automatic
echo "20161224 112233 1112222 1 hello-eric!" >>/Users/erichan/vangogh/logs/vanGogh.log

logstash -f ~/vangogh/vanGogh.ls.conf --config.test_and_exit
logstash -f ~/vangogh/vanGogh.ls.conf --config.reload.automatic

curl -XGET 'localhost:9200/_cat/indices?v'

curl -XGET 'localhost:9200/logstash-2016.12.23/_search?pretty' -d'{"query": {"match" : {"message": "hello Eric!"}}}'
