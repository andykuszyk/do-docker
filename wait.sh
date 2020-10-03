#!/bin/bash
for i in $(seq 1 30); do
    output=$(curl http://budjot.com -v 2>&1)
    if [[ "$(echo $output | grep 301)" == "" ]]; then
        echo "Failed attempt $i, sleeping"
        echo $output
        sleep 1
    else
        exit 0
    fi
done
echo "Failed after $i attempts"
