## Prerequisites

Make sure the kernel module loads at boot, since the container may not be able to load it itself

```shell
echo wireguard | sudo tee /etc/modules-load.d/wireguard.conf
```

## Wireguard config

```shell
sudo nano ./wg0.conf
```

```ini
[Interface]
Address = 10.0.0.2/24
MTU = 1400
PrivateKey = HOME_SERVER_PRIVATE_KEY_HERE

[Peer]
# VPS
PublicKey = VPS_PUBLIC_KEY_HERE
Endpoint = VPS_IP_HERE:51820
AllowedIPs = 10.0.0.1/32
PersistentKeepalive = 25
```

```shell
sudo chown 0:0 ./wg0.conf
sudo chmod 600 ./wg0.conf
```

## Useful commands later

```shell
journalctl -t homelab-proxy                  # everything, including old entries
journalctl -t homelab-proxy -g "no reply"    # every restart
journalctl -t homelab-proxy -g "recovered"   # every outage with its duration
docker ps                                    # current health status
```
