#!/bin/bash
function test() {
    if [[ "$(curl -L -k -v $1 2>&1 | grep '200 OK')" == "" ]]; then
        echo "curl $1 failed"
        exit 1
    else
        echo "curl $1 succeeded"
    fi
}

test http://budjot.com
test https://budjot.com
test http://akuszyk.com
test https://akuszyk.com
test http://marmyandme.co.uk
