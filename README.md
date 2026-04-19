<img width="2000" height="500" alt="Banner" src="https://github.com/user-attachments/assets/b1ccb746-1c7b-437c-a79d-4b52acb1a79d" /><br>

<p align="center">
    <!-- Discord Badge -->
    <a href="https://discord.justus0405.com/"><img src="https://img.shields.io/discord/1370519315400495234?logo=Discord&colorA=1e1e2e&colorB=a6e3a1&style=for-the-badge"></a>
    <!-- Forks Badge -->
    <a href="https://github.com/Justus0405/homelab/forks"><img src="https://img.shields.io/github/forks/Justus0405/homelab?colorA=1e1e2e&colorB=ea999c&style=for-the-badge"></a>
    <!-- Stars Badge -->
    <a href="https://github.com/Justus0405/homelab/stargazers"><img src="https://img.shields.io/github/stars/Justus0405/homelab?colorA=1e1e2e&colorB=b7bdf8&style=for-the-badge"></a>
    <!-- Last Commit Badge -->
    <a href="https://github.com/Justus0405/homelab/commits/main/"><img src="https://img.shields.io/github/last-commit/Justus0405/homelab?logo=github&colorA=1e1e2e&colorB=cdd6f4&style=for-the-badge"></a>
</p>

# Homelab

Personal homelab configuration, Docker stacks, and utility scripts for managing self-hosted services across Arch Linux and other systems.

## Quick Start

1. Clone the repository:

```shell
git clone --depth 1 https://github.com/Justus0405/homelab.git
```

2. Navigate to a stacks directory:

```shell
cd homelab/docker-compose/vaultwarden
```

3. Configure the stack (If needed):

```shell
cat .env.example
nano .env
```

4. Bring up the stack:

```shell
docker-compose up -d
```

## Repository Structure

### `configs/Arch Linux/`

System configuration files for Arch Linux, useful for replicating or restoring a base setup.

| File             | Purpose                                                                              |
| ---------------- | ------------------------------------------------------------------------------------ |
| `bashrc.txt`     | Shell configuration and aliases                                                      |
| `fstab.txt`      | Filesystem mount table                                                               |
| `grub.txt`       | Bootloader configuration                                                             |
| `mirrorlist.txt` | Pacman mirror list                                                                   |
| `pkglist.txt`    | Installed package list (for bulk reinstall via `pacman -S --needed - < pkglist.txt`) |

### `docker-compose/`

Each directory contains a `docker-compose.yml` (and any related notes & .env) for a self-hosted service.

| Stack                                                                           | Description                                       |
| ------------------------------------------------------------------------------- | ------------------------------------------------- |
| [beszel-agent](https://github.com/henrygd/beszel)                               | Lightweight server monitoring agent               |
| [beszel-server](https://github.com/henrygd/beszel)                              | Monitoring dashboard server                       |
| [duplicati](https://github.com/duplicati/duplicati)                             | Encrypted backup solution                         |
| [flame](https://github.com/pawelmalak/flame)                                    | Self-hosted start page and application dashboard  |
| [gotify](https://github.com/gotify/server)                                      | Self-hosted push notification server              |
| [immich](https://github.com/immich-app/immich)                                  | Photo and video management                        |
| [jellyfin](https://github.com/jellyfin/jellyfin)                                | Media server for movies, TV, and music            |
| [jotty](https://github.com/fccview/jotty)                                       | Lightweight note-taking app                       |
| [makemkv](https://github.com/jlesage/docker-makemkv)                            | Containerized disc ripping tool                   |
| [nginx-proxy-manager](https://github.com/NginxProxyManager/nginx-proxy-manager) | Reverse proxy with SSL and a web UI               |
| [torrent-stack](https://github.com/qdm12/gluetun)                               | Torrent client and related services               |
| [uptime-kuma](https://github.com/louislam/uptime-kuma)                          | Uptime monitoring and status pages                |
| [vaultwarden](https://github.com/dani-garcia/vaultwarden)                       | Lightweight Bitwarden-compatible password manager |
| [watchtower](https://github.com/nicholas-fedor/watchtower)                      | Automatic Docker container updates                |

### `scripts/`

Utility and setup scripts for common tasks across Arch and other hosts.

| Script                     | Description                                                 |
| -------------------------- | ----------------------------------------------------------- |
| `Arch-docker-eof-fix.sh`   | Fix for Docker EOF errors on Arch                           |
| `Arch-install-docker.sh`   | Docker installation for Arch Linux                          |
| `Arch-install-playit.sh`   | Install [playit.gg](https://playit.gg) tunnel agent on Arch |
| `Arch-update-playit.sh`    | Update playit.gg on Arch                                    |
| `Debian-install-docker.sh` | Docker installation for Debian                              |
| `Debian-install-playit.sh` | Install playit.gg tunnel agent on Debian                    |
| `permissions-fixer.sh`     | Bulk fix file/directory permissions                         |
| `sha256compare.sh`         | Compare SHA-256 checksums for file verification             |

### `testing/`

Experimental or in-progress stacks not yet promoted to production.

| Stack         | Description                    |
| ------------- | ------------------------------ |
| llama         | LLM inference via llama.cpp    |
| nginx         | Nginx web server testing       |
| ollama        | LLM inference via Ollama       |
| openspeedtest | Self-hosted network speed test |

#

<p align="center">
	Copyright &copy; 2026-present <a href="https://github.com/Justus0405" target="_blank">Justus0405</a>
</p>

<p align="center">
	<a href="https://github.com/Justus0405/homelab/blob/main/LICENSE"><img src="https://img.shields.io/github/license/Justus0405/homelab?logo=Github&colorA=1e1e2e&colorB=cba6f7&style=for-the-badge"></a>
</p>
