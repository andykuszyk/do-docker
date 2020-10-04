#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
scp -i id_rsa -o "StrictHostKeyChecking no" ./docker-compose.* $douser@$doip:~
ssh -i id_rsa -o "StrictHostKeyChecking no" $douser@$doip 'docker-compose up -f docker-compose.yml -f docker-compose.do.yml'
