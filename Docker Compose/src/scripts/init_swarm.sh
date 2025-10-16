#!/bin/bash

docker swarm init --advertise-addr 192.168.56.10

docker swarm join-token worker -q > /vagrant/shared_token/worker_token
chown vagrant:vagrant /vagrant/shared_token/worker_token
