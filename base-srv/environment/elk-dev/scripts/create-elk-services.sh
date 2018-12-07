#!/usr/bin/env bash

networkid=$(docker network ls -f name=elk_bridge -q)
if [$networkid -eq '']
then
    docker network create --attachable elk_bridge
else
    echo 'network exist skip step'
fi
docker login -u artdocker -p 'artDocker$Pull' docker-virtual.artifactory.igentify.net

# Elasticsearch service
docker pull docker-virtual.artifactory.igentify.net/elasticsearch/elasticsearch:5.6.4
sudo docker run -d --name=elasticsearch --network=elk_bridge -m 2.5G --restart=always -p 9200:9200 -p 9300:9300 --name=elasticsearch -v /vagrant/environment/elk-dev/elasticsearch/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml docker-virtual.artifactory.igentify.net/elasticsearch/elasticsearch:5.6.4


sudo docker pull docker-virtual.artifactory.igentify.net/logstash/logstash:5.6.4
sudo docker run -d --name=logstash --network=elk_bridge -m 0.5G --restart=always -p 5000:5000 --name=logstash -v /vagrant/environment/elk-dev/logstash/settings/logstash.yml:/usr/share/logstash/config/logstash.yml -v /vagrant/environment/elk-dev/logstash/pipeline/:/usr/share/logstash/pipeline/ docker-virtual.artifactory.igentify.net/logstash/logstash:5.6.4


sudo docker pull docker-virtual.artifactory.igentify.net/kibana/kibana:5.6.4
sudo docker run -d --name=kibana --network=elk_bridge -m 1.5G --restart=always -p 5601:5601 -v /vagrant/environment/elk-dev/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml docker-virtual.artifactory.igentify.net/kibana/kibana:5.6.4
