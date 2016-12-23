## elasticsearch
### install
```
brew install/list/upgrade elasticsearch
```

```
Data:    /usr/local/var/elasticsearch/elasticsearch_erichan/
Logs:    /usr/local/var/log/elasticsearch/elasticsearch_erichan.log
Plugins: /usr/local/Cellar/elasticsearch/5.1.1/libexec/plugins/
Config:  /usr/local/etc/elasticsearch/
plugin script: /usr/local/Cellar/elasticsearch/5.1.1/libexec/bin/plugin

To have launchd start elasticsearch now and restart at login:
  brew services start elasticsearch
Or, if you don't want/need a background service you can just run:
  elasticsearch
```
### start
```
elasticsearch
```

## logstash
### install
```
brew install/list/upgrade logstash
```

### ~/vangogh/vanGogh.ls.conf
```yml
input {
    beats {
        port => "5043"
    }
}
 filter {
    grok {
        match => { "message" => "%{COMBINEDAPACHELOG}"}
    }
    geoip {
        source => "clientip"
    }
}
output {
    stdout { codec => rubydebug }
}
```
### test conf
```
logstash -f ~/vangogh/vanGogh.ls.conf --config.test_and_exit
```
### start
```sh
logstash -f ~/vangogh/vanGogh.ls.conf --config.reload.automatic
```

## filebeat
### install
```
brew install/list/upgrade filebeat
```

```
To have launchd start filebeat now and restart at login:
  brew services start filebeat
Or, if you don't want/need a background service you can just run:
  filebeat
```

### ~/vangogh/vanGogh.sh
> ~/vangogh/logs/vanGogh.log

```
#!/bin/sh
#
# vanGogh script.
# 2016.12.21
#

scriptPath=$(cd $(dirname $0);pwd)
cd $scriptPath
mkdir logs  2>/dev/null && touch vanGogh.log

messages=("Vincent" "Eric" "Paul" "Michael" "Kevin" "Sam" "Bill")
i=1
while [ ${i} -le 60 ]
do
  vanId=$RANDOM
  timestamp=$(date +%s)
  time=$(date +%Y%m%d-%H%M)
  n=$((RANDOM % ${#messages[@]} ))
  echo "${time}|${vanId}|${timestamp}|$n|hello ${messages[$n]}!" >>logs/vanGogh.log
  sleep 1s 
  ((i++))
done
```

### start vanGogh.sh
```
sh ~/vangogh/vanGogh.sh
```

### ~/vangogh/vanGogh.fb.yml
```yml
filebeat.prospectors:
- input_type: log
  paths:
    - ~/vangogh/logs/vanGogh.log
output.logstash:
  hosts: ["localhost:5043"]
```

### start
```
filebeat -c ~/vangogh/vanGogh.fb.yml
```


```
brew install/list/upgrade kibana
```

```
Config: /usr/local/etc/kibana/
If you wish to preserve your plugins upon upgrade, make a copy of
/usr/local/opt/kibana/plugins before upgrading, and copy it into the
new keg location after upgrading.

To have launchd start kibana now and restart at login:
  brew services start kibana
Or, if you don't want/need a background service you can just run:
  kibana
```  


1. Elasticsearch for Hadoop https://www.elastic.co/guide/en/elasticsearch/hadoop/current/index.html
2. Elasticsearch指南 https://www.elastic.co/guide/en/elasticsearch/guide/current/index.html
3. Elasticsearch文档 https://www.elastic.co/guide/en/elasticsearch/reference/current/index.html
4. https://www.elastic.co/guide/en/logstash/current/index.html
5. https://www.elastic.co/guide/en/kibana/current/index.html