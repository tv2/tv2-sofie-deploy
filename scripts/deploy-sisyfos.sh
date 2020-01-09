#!/bin/bash
source set-environment.sh

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
	--mount source=sisyfos-vol,target=/opt/sisyfos-audio-controller/storage \
	-e loggerIp=$ELASTIC_IP \
	-e loggerPort=$ELASTIC_PORT \
	--network=$NETWORK_NAME \
	--restart always -d \
	olzzon/sisyfos-audio-controller:$TAG
if [ $? -ne 0 ]; then
        echo "Failed to run new image. Sisyfos is likely not running"
        exit $?
fi

echo "Deployed $TAG"
