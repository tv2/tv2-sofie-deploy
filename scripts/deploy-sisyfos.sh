#!/bin/bash

read -e -p "Tag to deploy: " -i "develop" TAG

sudo docker pull olzzon/sisyfos-audio-controller:$TAG
if [ $? -ne 0 ]; then
	echo "Failed to pull image. Aborting"
	exit $?
fi

sudo docker stop sisyfos
sudo docker rm sisyfos


HOSTNAME=$(hostname)
sudo docker run --name=sisyfos \
	-i \
	--mount source=sisyfos-vol,target=/opt/sisyfos-audio-controller/storage \
	-e loggerIp='0.0.0.0' \
	-e loggerPort=9200 \
	--network="host" \
	--restart always \
	-t \
	olzzon/sisyfos-audio-controller:$TAG
if [ $? -ne 0 ]; then
        echo "Failed to run new image. Sisyfos is likely not running"
        exit $?
fi

echo "Deployed $TAG"
