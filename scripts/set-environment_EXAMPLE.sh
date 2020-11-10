#!/bin/bash

# For all containers:
export NETWORK_NAME=sofie
export TIMEZONE=Europe/Copenhagen
export NTP_SERVERS=pool.ntp.org
# For Playout and iNews gateways:
export DEVICE_TOKEN=XXXXXXXXXXXXXXXX
# For deploy blueprints:
export HTTP_PROXY= # eg. http://XX.XX.XX.XX:8080
export ENV_SERVER=xx.local.xx # address of core to use for uploading the blueprints
# For Sisyfos:
export ELASTIC_IP=0.0.0.0
export ELACTIC_PORT=9200

# For nginx.conf
export CORE_DOMAIN= # eg. sofie.xxxx.local
export DISABLE_HTTP=false # (true/false) if users shoud be always redirected to HTTPS
export SSL_CERTIFICATE= # eg. /home/user/certificate.cer
export SSL_CERTIFICATE_KEY= # eg. /home/user/certificate.key
export MEDIA_PREVIEW_URL= # eg. http://XX.XX.XX.XX:8000
# For nginx.conf QBox only
export IS_QBOX=false # (true/false) set to true on a QBox
export SISYFOS_URL= # eg. http://localhost:1176 (if sisyfos deployed on the same machine as core)
export IMAGE_PROVIDER_URL= # eg. http://XX.XX.XX.XX:5255