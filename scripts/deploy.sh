#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
yq m -x docker-compose.yml docker-compose.do.yml > docker-compose.release.yml
scp -i id_rsa -o "StrictHostKeyChecking no" ./docker-compose.release.yml $douser@$doip:~
scp -i id_rsa -o "StrictHostKeyChecking no" ./nginx.conf $douser@$doip:~
ssh -i id_rsa -o "StrictHostKeyChecking no" $douser@$doip 'docker stack deploy -c docker-compose.release.yml szyk'
