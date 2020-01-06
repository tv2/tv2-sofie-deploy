# tv2-sofie-deploy
Deployment scripts for Sofie Automation System on Linux.


All assets: tv2-sofie-deploy
- Remaining tasks
- Blueprints deployment
- Httpproxy for core to webhook slack?
- Core ntp servers?
- Kibana logging
- Nginx ssl?

    
### Steps
Install docker
```
https://docs.docker.com/install/linux/docker-ce/ubuntu/
```
Setup docker proxy:
```
https://docs.docker.com/engine/admin/systemd/ 
```
Create docker virtual network
```
sudo docker network create sofie
```
Run mongo
```
sudo docker run -d --restart=always --network=sofie --hostname=mongodb -v /opt/mongo/db:/data/db -v /opt/mongo/backup:/data/backup -v /etc/timezone:/etc/timezone:ro -p 127.0.0.1:27017:27017 --name mongo mongo:3.4 --replSet rs0
```
Configure mongo replicaset
```
sudo docker exec -it mongo bash
mongo
rs.initiate()
exit
exit
```
Run images
```
sudo bash deploy-core.sh
sudo bash deploy-playout-gateway.sh
sudo bash deploy-inews-gateway.sh
sudo bash deploy-sisyfos.sh
```
Deploy blueprints
TODO
Install nginx
````
sudo apt-get install nginx
````
Configure nginx
TODO - this may need more tweaking
```
sudo cp nginx.conf /etc/nginx/
```