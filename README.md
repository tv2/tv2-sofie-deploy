# tv2-sofie-deploy
Deployment scripts for Sofie Automation System on Linux.

## Steps:

Install NodeJS and Yarn

#### To install Yarn on ubuntu 18.04 see here:
```
https://linuxize.com/post/how-to-install-yarn-on-ubuntu-18-04/
```


### Edit private and machine dependend settings:
```
cd scripts
cp set-environment_EXAMPLE.sh set-environment.sh
nano set-environment.sh
./set-environment.sh
```
### Install docker
https://docs.docker.com/install/linux/docker-ce/ubuntu/

### Setup docker proxy:
https://docs.docker.com/engine/admin/systemd/ 

### Create docker virtual network
```
sudo docker network create sofie
```
### Run mongo
Note: `--network=sofie` needs to match NETWORK_NAME from set-environment.sh
```
sudo -E docker run -d --restart=always --network=sofie --hostname=mongodb -v /opt/mongo/db:/data/db -v /opt/mongo/backup:/data/backup -v /etc/timezone:/etc/timezone:ro -p 127.0.0.1:27017:27017 --name mongo mongo:3.4 --replSet rs0
```
### Configure mongo replicaset
```
sudo docker exec -it mongo mongo --eval "rs.initiate()"
```

### (Optional) Setup filebeat to log to kibana
* https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-installation.html
* Edit the `output.elasticsearch:` properties in filebeat.yml to match your setup
* `sudo cp filebeat.yml /etc/filebeat/`
* Restart filebeat
* Indexes in kibana will need to be created manually to match those in elasticsearch

### Setup blueprints deployment:
```
cd scripts
git clone https://github.com/olzzon/tv2-sofie-blueprints-inews.git
cd tv2-sofie-blueprints-inews
yarn
```
Deploy the blueprints from the deployment scriptmenu. (later in this README.md)

### Install nginx:
```
sudo apt-get install nginx
sudo cp nginx.conf /etc/nginx/
sudo service nginx reload
```

### Deploy scripts with menu:
```
sudo ./menu.sh
```

## Future steps:
- Httpproxy for core to webhook slack?
- Nginx ssl?
