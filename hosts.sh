#!/bin/bash
function add_host() {
    echo "Adding $1 to /etc/hosts"
    if [[ "$(cat /etc/hosts | grep $1)" == "" ]]; then
        echo "127.0.0.1 $1" >> /etc/hosts
    fi
}

add_host 'budjot.com'
add_host 'akuszyk.com'
add_host 'marmyandme.co.uk'

echo "/etc/hosts now looks like this:"
cat /etc/hosts

