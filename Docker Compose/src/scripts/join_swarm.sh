
#!/bin/bash

while [ ! -f /vagrant/shared_token/worker_token ]; do
  sleep 2
done

TOKEN=$(cat /vagrant/shared_token/worker_token)

docker swarm join --token $TOKEN 192.168.56.10:2377