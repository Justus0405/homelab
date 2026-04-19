#!/usr/bin/env bash

docker-compose down
docker-compose pull
docker-compose up -d --force-recreate
docker-compose logs --follow gluetun
