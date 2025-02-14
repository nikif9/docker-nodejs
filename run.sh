#!/bin/bash
set -e

IMAGE_NAME="my-fullstack-app"
CONTAINER_NAME="fullstack_app"

# Сборка Docker-образа
docker build -t $IMAGE_NAME .

# Запуск контейнера в фоне
docker run -d -p 3000:3000 -p 8089:8089  --name $CONTAINER_NAME $IMAGE_NAME
