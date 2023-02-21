#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
sed -i "s/GRAFANA_API_KEY/$GRAFANA_API_KEY/g" promtail.yaml
yq m -x docker-compose.yml docker-compose.do.yml > docker-compose.release.yml
scp -i id_rsa ./docker-compose.release.yml $DOUSER@$DOIP:~
scp -i id_rsa ./nginx.conf $DOUSER@$DOIP:~
scp -i id_rsa ./promtail.yaml $DOUSER@$DOIP:~
ssh -i id_rsa $DOUSER@$DOIP 'docker stack deploy -c docker-compose.release.yml szyk'
