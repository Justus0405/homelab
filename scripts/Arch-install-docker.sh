#!/usr/bin/env bash

# Install Docker and Docker Compose packages
sudo pacman -S docker docker-compose docker-buildx

# Enable and start the Docker service
sudo systemctl enable --now docker

# Add your user to the Docker group (so you can run Docker without sudo)
sudo usermod -aG docker "$(whoami)"
