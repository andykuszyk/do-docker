#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
scp -i id_rsa -o "StrictHostKeyChecking no" ./docker-compose.* $douser@$doip:~
scp -i id_rsa -o "StrictHostKeyChecking no" ./nginx.conf $douser@$doip:~
ssh -i id_rsa -o "StrictHostKeyChecking no" $douser@$doip 'docker stack deploy -c docker-compose.yml -c docker-compose.do.yml szyk'
