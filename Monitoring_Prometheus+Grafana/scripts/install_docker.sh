#!/bin/bash

sudo apt-get update 

# Устанавливаем необходимые пакеты для использования репозиторий через HTTPS
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

# Добавляем официальный GPG ключ Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Добавляем Docker репозиторий
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

# Устанавливаем Docker
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y


usermod -aG docker vagrant
