#!/bin/bash

# Instructions for use:
# 1. Copy the script to the server and install packages
#     scp initialise-server.sh root@<server-ip-address>:~/
#     ssh root@<server-ip-address>
#     source initialise-server.sh
#     install
# 2. Deploy the docker-compose.yml file via GH actions
# 3. Setup the TLS certificates:
#    ssh root@<server-ip-address>
#    source initialise-server.sh
#    generate_certificates

function install_packages() {
    echo "===> Installing packages"
    apt-get update
    apt-get install ca-certificates curl gnupg lsb-release certbot
}

function install_docker() {
    echo "===> Installing Docker"
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update
    apt-get install docker-ce docker-ce-cli containerd.io
}

function setup_docker_swarm() {
    ip_address=$(ifconfig eth0 | grep inet | head -n 1 | awk '{print $2}')
    echo "===> Setting up Docker swarm with an IP address of $ip_address"
    docker swarm init --advertise-addr "$ip_address"
}

function generate_certificates() {
    for site in marmyandme.co.uk cronical.net budjot.com akuszyk.com; do
        echo "===> Generating TLS certificate for $site"
        sudo certbot certonly --webroot -w /root/certs-data/ -d "$site" -d "www.$site"
    done
}

function setup_ufw() {
    echo "===> Enabling ufw"
    ufw allow 22
    ufw allow 80
    ufw allow 443
    ufw enable
    ufw status verbose
}

function setup_cron_jobs() {
    echo "===> Setting up cron jobs"
    setup_cron_job "0 0 * * * root docker ps | grep budjot | awk '{print \$1}' | xargs docker kill" "kill budjot"
    setup_cron_job "0 0 * * * root docker ps | grep nginx | awk '{print \$1}' | xargs docker kill" "kill nginx"
}

function setup_cron_job() {
    cron_job=$1
    description=$2

    if [[ "$(cat /etc/crontab | grep "$description")" != "" ]]; then
        echo "===> cron job '$description' already exists, skipping"
    else
        echo "$cron_job # $description" >> /etc/crontab
    fi
}

function install() {
    install_packages
    install_docker
    setup_docker_swarm
    setup_ufw
    setup_cron_jobs
}
