#!/bin/bash
function test() {
    output=$(curl -L -k -v $1 2>&1)
    if [[ "$(echo $output | grep '200 OK')" == "" ]]; then
        echo "curl $1 failed"
        echo $output
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
test https://marmyandme.co.uk
test http://shop.marmyandme.co.uk
test https://shop.marmyandme.co.uk
test http://cronical.net
test https://cronical.net
