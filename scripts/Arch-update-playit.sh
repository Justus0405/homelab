#!/usr/bin/env bash

# Stopping playit service
echo -e "Stopping playit agent..."
sudo systemctl stop playit.service

# Downloading agent
echo -e "Downloading playit agent for x86_64..."
curl -o "${HOME}/agent" -SsL "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64" || exit 1
echo -e "Done!"

# Setting Execute Permission
echo -e "Setting executable permissions..."
chmod +x "${HOME}/agent"
echo -e "Done!"

# Moving agent
echo -e "Moving agent to /opt/playit..."
sudo mv "${HOME}/agent" "/opt/playit/"

# Starting playit service again
echo -e "Starting playit service..."
sudo systemctl start playit.service

# Done
echo -e "Successfully updated the playit agent!"
