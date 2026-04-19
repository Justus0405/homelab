#!/usr/bin/env bash
docker stop makemkv
docker rm makemkv
docker image prune makemkv
docker-compose up -d
