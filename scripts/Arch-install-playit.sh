#!/usr/bin/env bash

# Download Playit Agent
echo -e "Downloading Playit Agent for x86_64..."
curl -o "${HOME}/agent" -SsL "https://github.com/playit-cloud/playit-agent/releases/latest/download/playit-linux-amd64" || exit 1
echo -e "Done!"

# Setting Execute Permission
echo -e "Setting executable permissions..."
chmod +x "${HOME}/agent"
echo -e "Done!"

# Create Directories and Set Permissions
echo -e "Creating Directorys and setting permissions..."
sudo mkdir -p "/opt/playit" "/etc/playit" "/var/log/playit" || exit 1
sudo chown -R "${USER}" "/opt/playit/" "/etc/playit/" "/var/log/playit/"
echo -e "Done"

# Move Agent
echo -e "Moving agent to /opt/playit..."
sudo mv "${HOME}/agent" "/opt/playit/"

# Create pseudo files
echo -e "Creating pseudo files... (idk why but was in the original debian package)"
sudo tee "/opt/playit/playit" >/dev/null <<EOF
#!/usr/bin/env bash
/opt/playit/agent \$@
EOF
sudo chmod +x "/opt/playit/playit"

sudo tee "/usr/local/bin/playit" >/dev/null <<EOF
#!/usr/bin/env bash
/opt/playit/agent \$@
EOF
sudo chmod +x "/usr/local/bin/playit"

# Create Service
echo -e "Creating service file..."
sudo tee "/lib/systemd/system/playit.service" >/dev/null <<EOF
[Unit]
Description=Playit Agent
Documentation=https://playit.gg
Wants=network-pre.target
After=network-pre.target NetworkManager.service systemd-resolved.service

[Service]
ExecStart=/opt/playit/playit --secret_wait --secret_path /etc/playit/playit.toml -l /var/log/playit/playit.log start
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

# Setting up playit
# NOTE: after adding the tunnel, during the attempting to connect sequence
# its important that the service is running, if it failes one time thats normal.
echo -e "Starting Playit setup..."
playit setup
sudo systemctl enable --now playit.service

# Done
echo -e "Successfully Installed the Playit Agent!"
