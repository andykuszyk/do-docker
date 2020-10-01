#!/bin/bash
for i in 1 2 3 4 5 6 7 8 9 10; do
    if [[ "$(curl http://budjot.com -v 2>&1 | grep 301)" == "" ]]; then
        echo "Failed attempt $i, sleeping"
        sleep 1
    else
        exit 0
    fi
done
echo "Failed after $i attempts"
