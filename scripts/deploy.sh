#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
scp -i id_rsa -o "StrictHostKeyChecking no" ./docker-compose.* $douser@$doip:~
scp -i id_rsa -o "StrictHostKeyChecking no" ./nginx.conf $douser@$doip:~
ssh -i id_rsa -o "StrictHostKeyChecking no" $douser@$doip 'docker-compose -f docker-compose.yml -f docker-compose.do.yml up -d'
