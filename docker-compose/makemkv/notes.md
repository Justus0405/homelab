# MakeMKV Docker Setup & Configuration

## Fix: No Optical Drive Found

For Arch:

1. Do this to load the driver: `echo "sg" | sudo tee /etc/modules-load.d/sg.conf`
2. Reboot.

For Debian:

1. Do: "ls /dev/sg\*"
2. Only inculde sr0 and the ones the command printed.
