#!/bin/bash
image=$1
tag=$2
sed -i '' "s/image\: andykuszyk\/$image\:.*/image: andykuszyk\/$image:$tag/g" docker-compose.yml
git status
git add docker-compose.yml
git commit -m "Auto-release of $image to andykuszyk/$image:$tag"
git push
