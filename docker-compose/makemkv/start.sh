#!/usr/bin/env bash
docker stop makemkv
docker rm makemkv
docker image rm makemkv
docker-compose up -d
