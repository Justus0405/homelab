#!/usr/bin/env bash

# Stop Playit Service
echo -e "Stopping Playit Service..."
sudo systemctl disable --now playit.service

# Delete Playit Directories
echo -e "Deleting Playit Directories..."
sudo rm -rf "/opt/playit" "/etc/playit" "/var/log/playit" || exit 1
echo -e "Done"

# Delete pseudo files
echo -e "Deleting pseudo files..."
sudo rm "/usr/local/bin/playit"

# Delete Service
echo -e "Deleting service file..."
sudo rm "/lib/systemd/system/playit.service"

# Done
echo -e "Successfully Uninstalled the Playit Agent!"
