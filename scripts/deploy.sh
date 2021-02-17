#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
sed -i "s/opencart_username/$opencart_username/g" docker-compose.do.yml
sed -i "s/opencart_password/$opencart_password/g" docker-compose.do.yml
sed -i "s/opencart_email/$opencart_email/g" docker-compose.do.yml
sed -i "s/opencart_database_user/$opencart_database_user/g" docker-compose.do.yml
sed -i "s/opencart_database_password/$opencart_database_password/g" docker-compose.do.yml
sed -i "s/mariadb_root_password/$mariadb_root_password/g" docker-compose.do.yml
yq m -x docker-compose.yml docker-compose.do.yml > docker-compose.release.yml
scp -i id_rsa -o "StrictHostKeyChecking no" ./docker-compose.release.yml $douser@$doip:~
scp -i id_rsa -o "StrictHostKeyChecking no" ./nginx.conf $douser@$doip:~
ssh -i id_rsa -o "StrictHostKeyChecking no" $douser@$doip 'docker stack deploy -c docker-compose.release.yml szyk'
