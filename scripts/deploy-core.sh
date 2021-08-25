#!/bin/bash
source set-environment.sh

read -e -p "Tag to deploy: " -i "develop" TAG

read -e -p "Deploy core-settings.json? [y/n] " -i "" DEPLOY_JSON

if [[ $DEPLOY_JSON == y* ]] || [[ $DEPLOY_JSON == Y* ]]; then
	echo "Which settings to copy?"
	PS3='Please enter your choice: '
	files=()
	while IFS= read -r -d $'\0'; do
		files+=("$REPLY")
	done < <(find ../core-settings/ -type f -printf "%f\0")
	select opt in "${files[@]}" ; do 
		if (( REPLY > 0 && REPLY <= ${#files[@]} )) ; then
    		sudo cp -f "../core-settings/$opt" /opt/core-settings.json
			echo  "Copied $opt"
			break

		else
			echo "Invalid option"
		fi
	done
fi

sudo docker pull olzzon/tv-automation-server-core:$TAG
if [ $? -ne 0 ]; then
	echo "Failed to pull image. Aborting"
	exit $?
fi

sudo docker stop server-core
sudo docker rm server-core

# TODO - slack webhooks probably need the proxy?

HOSTNAME=$(hostname)
sudo docker run --name=server-core \
	--network=$NETWORK_NAME \
	-p 127.0.0.1:8080:80/tcp \
	--restart always -d \
	-v /opt/coredisk:/opt/coredisk \
	-v /opt/core-settings.json:/opt/core-settings.json:ro \
	-e 'TZ=$TIMEZONE' \
	-e 'MONGO_OPLOG_URL=mongodb://mongo:27017/local' \
	-e 'MONGO_URL=mongodb://mongo:27017/sofie' \
	-e "ROOT_URL=http://$HOSTNAME" \
	-e "NTP_SERVERS=$NTP_SERVERS" \
	-e 'PORT=80' \
	-e 'HTTP_FORWARDED_COUNT=1' \
	olzzon/tv-automation-server-core:$TAG
if [ $? -ne 0 ]; then
        echo "Failed to run new image. Sofie is likely not running"
        exit $?
fi

echo "Deployed $TAG"
