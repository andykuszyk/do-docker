#!/bin/bash
sed -i "s/gitlabtoken/$GITLAB_TOKEN/g" docker-compose.do.yml
sed -i "s/opencart_username/$OPENCART_USERNAME/g" docker-compose.do.yml
sed -i "s/opencart_password/$OPENCART_PASSWORD/g" docker-compose.do.yml
sed -i "s/opencart_email/$OPENCART_EMAIL/g" docker-compose.do.yml
sed -i "s/opencart_database_user/$OPENCART_DATABASE_USER/g" docker-compose.do.yml
sed -i "s/opencart_database_password/$OPENCART_DATABASE_PASSWORD/g" docker-compose.do.yml
sed -i "s/mariadb_root_password/$MARIADB_ROOT_PASSWORD/g" docker-compose.do.yml
yq m -x docker-compose.yml docker-compose.do.yml > docker-compose.release.yml
scp -i id_rsa  ./docker-compose.release.yml $DOUSER@$DOIP:~
#scp -i id_rsa -o "StrictHostKeyChecking no" ./nginx.conf $DOUSER@$DOIP:~
#ssh -i id_rsa -o "StrictHostKeyChecking no" $DOUSER@$DOIP 'docker stack deploy -c docker-compose.release.yml szyk'
