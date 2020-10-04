#!/bin/bash
for i in $(seq 1 30); do
    output=$(curl -L -k http://budjot.com -v 2>&1)
    if [[ "$(echo $output | grep '200 OK')" == "" ]]; then
        echo "Failed attempt $i, sleeping"
        echo $output
        sleep 1
    else
        exit 0
    fi
done
echo "Failed after $i attempts"
