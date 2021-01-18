#!/bin/bash
repo="aws-cloudformation/cfn-python-lint"
output=$(curl -sL https://api.github.com/repos/${repo}/tags |jq -r ".[].name"|sort -Vr |head -1)
echo 'The latest version is '$output

image='eddieorg/cfn-lint'
status=$(curl -sL https://hub.docker.com/v2/repositories/${image}/tags/${tags})
#echo $status

if [[ ${status} == *${output}* ]]; then
  echo 'Tag exists'
fi

if [[ ${status} != *${output}* ]]; then
   docker build --build-arg version=${output} -t ${image}:${output} .
   docker build --build-arg version=${output} -t ${image}:latest .
   #docker tag ${image}:${output} ${image}:latest
   docker push ${image}:${output}
   docker push ${image}:latest
fi
#docker build --build-arg version=${output} -t ${image}:${output} .
#docker push ${image}:${output}

