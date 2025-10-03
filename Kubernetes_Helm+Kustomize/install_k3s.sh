#!/bin/bash

ROLE=$1
MASTER_IP=$2
NODE_IP=$3
TOKEN_FILE="/shared/node-token"

if [ "$ROLE" == "master" ]; then
    echo "Установка k3s на мастер-узле..."
    curl -sfL https://get.k3s.io | sh -s - server \
        --advertise-address=$NODE_IP \
        --node-ip=$NODE_IP \
        --disable=traefik
    echo "Мастер установлен."

    sudo cp /var/lib/rancher/k3s/server/node-token $TOKEN_FILE
    echo "Токен сохранён в $TOKEN_FILE"

elif [ "$ROLE" == "worker" ]; then
    echo "Ожидание токена мастера..."
    while [ ! -f "$TOKEN_FILE" ]; do
        sleep 2
    done

    NODE_TOKEN=$(cat $TOKEN_FILE)
    echo "Токен найден: $NODE_TOKEN"

    echo "Подключение к мастеру $MASTER_IP с IP воркера $NODE_IP"
    curl -sfL https://get.k3s.io | \
        K3S_URL=https://$MASTER_IP:6443 \
        K3S_TOKEN=$NODE_TOKEN \
        sh -s - --node-ip=$NODE_IP

    echo "Воркер подключен к мастеру $MASTER_IP"
fi
