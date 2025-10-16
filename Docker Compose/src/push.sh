#!/bin/bash

DOCKER_USER="corazono"


images=$(sudo docker images --format "{{.Repository}}:{{.Tag}}" | grep -vE '^(rabbitmq|postgres|nginx):')

for local_tag in $images; do

  image_name=$(echo "$local_tag" | cut -d':' -f1 | awk -F'/' '{print $NF}')  

  remote_tag="${DOCKER_USER}/${image_name}:1.0"

  echo "Tagging $local_tag as $remote_tag"
  sudo docker tag "$local_tag" "$remote_tag"

  echo "Pushing $remote_tag"
  sudo docker push "$remote_tag"
done

echo "All applicable images tagged and pushed. ^_^"

