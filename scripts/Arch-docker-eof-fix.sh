#!/bin/bash

sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json >/dev/null <<EOF
{
  "max-concurrent-downloads": 1
}
EOF
sudo systemctl restart docker
echo -e "Done"
