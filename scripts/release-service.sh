#!/bin/bash
image=$1
tag=$2
sed -i '' "s/image\: andykuszyk\/$image\:.*/image: andykuszyk\/$image:$tag/g" docker-compose.yml
