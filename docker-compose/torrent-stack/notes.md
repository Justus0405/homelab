# Torrent Stack Docker Setup & Configuration

## Setup Notes

1. Create all download directories before starting the stack.
2. Every service except Gluetun uses `network_mode: "service:gluetun"`. Ports are published on Gluetun only, never on the app containers.
3. All apps share Gluetun's network namespace, so they reach each other over `localhost`. No container hostnames needed anywhere.
4. Downloads and the media library must be on the same filesystem. Hardlinks only work inside one filesystem.
5. The downloads root is mounted at `/downloads` in Transmission, SABnzbd, Radarr and Sonarr. Identical path in every container, otherwise imports fail.
6. Verify the tunnel is up: `docker exec -it transmission curl ifconfig.me` (must not return your ISP IP).
7. `FIREWALL_OUTBOUND_SUBNETS` must match your LAN subnet, otherwise you cannot reach the web UIs.
8. Optional: `VPN_PORT_FORWARDING=on` in Gluetun for ProtonVPN, then use the forwarded port as Transmission's peer port.
9. Optional: BT blocklist `https://raw.githubusercontent.com/Naunter/BT_BlockLists/master/bt_blocklists.gz`

## Folder Layout

```shell
mkdir -p /hdd-1-4tb/downloads/{torrents/{incomplete,movies,tv},usenet/{incomplete,movies,tv}}
```

```
/hdd-1-4tb/
├── downloads/
│   ├── torrents/
│   │   ├── incomplete/
│   │   ├── movies/
│   │   └── tv/
│   └── usenet/
│       ├── incomplete/
│       ├── movies/
│       └── tv/
└── jellyfin/
    └── media/
        ├── movies_german/
        └── shows_german/
```

## Mount Map

| Host path                                 | Container path | Used by                               |
| ----------------------------------------- | -------------- | ------------------------------------- |
| `/hdd-1-4tb/downloads`                    | `/downloads`   | Transmission, SABnzbd, Radarr, Sonarr |
| `/hdd-1-4tb/jellyfin/media/movies_german` | `/movies`      | Radarr                                |
| `/hdd-1-4tb/jellyfin/media/shows_german`  | `/tv`          | Sonarr                                |
| `/hdd-1-4tb/jellyfin/media`               | `/media`       | Jellyfin                              |

Jellyfin reads the library at `/media/movies_german` and `/media/shows_german`, the \*arrs write to the same folders as `/movies` and `/tv`.

## Ports

All published on Gluetun. Moving a port to an app container breaks it while it shares Gluetun's network stack.

| Port          | Service                |
| ------------- | ---------------------- |
| 9091          | Transmission           |
| 9191          | Prowlarr               |
| 51413 tcp/udp | Transmission peer port |
| 8191          | Flaresolverr           |
| 7878          | Radarr                 |
| 8989          | Sonarr                 |
| 6868          | Profilarr              |
| 8080          | SABnzbd                |

## Setup Order

1. Transmission -> Settings -> Downloads -> download to `/downloads/torrents`, incomplete `/downloads/torrents/incomplete`.
2. SABnzbd -> Settings -> Folders -> temp `/downloads/usenet/incomplete`, complete `/downloads/usenet`.
3. SABnzbd -> Settings -> Categories -> add `movies` (`*/movies`), `tv` (`*/tv`).
4. Radarr -> Settings -> Media Management -> add root folder `/movies`, enable rename.
5. Sonarr -> Settings -> Media Management -> add root folder `/tv`, enable rename episodes.
6. Add download clients (see table below) in Radarr and Sonarr.
7. Prowlarr -> Settings -> Apps -> add Radarr `http://localhost:7878` and Sonarr `http://localhost:8989` with their API keys. Indexers only get added in Prowlarr, never directly in Radarr or Sonarr.
8. Prowlarr -> Settings -> Indexer Proxies -> add FlareSolverr, host `http://localhost:8191`, tag `flaresolverr`. Apply that tag to Cloudflare-protected indexers only.
9. Profilarr -> `http://<host>:6868` -> add root paths, download clients and the apps, then add the uplink `https://github.com/Dictionarry-Hub/trash-pcd/tree/german`.

## Download Client Settings

| App    | Client       | Host        | Port | Category | Directory                    |
| ------ | ------------ | ----------- | ---- | -------- | ---------------------------- |
| Radarr | Transmission | `localhost` | 9091 | `movies` | `/downloads/torrents/movies` |
| Radarr | SABnzbd      | `localhost` | 8080 | `movies` | set by SABnzbd category      |
| Sonarr | Transmission | `localhost` | 9091 | `tv`     | `/downloads/torrents/tv`     |
| Sonarr | SABnzbd      | `localhost` | 8080 | `tv`     | set by SABnzbd category      |

## Categories

| Category | Torrent path                 | Usenet path                |
| -------- | ---------------------------- | -------------------------- |
| `movies` | `/downloads/torrents/movies` | `/downloads/usenet/movies` |
| `tv`     | `/downloads/torrents/tv`     | `/downloads/usenet/tv`     |

## Fix: Downloads Finish But Nothing Gets Imported

Check Radarr/Sonarr -> Activity -> Queue. The orange icon shows the reason, including the exact path it searched.

1. Path mismatch: SABnzbd reports its completed folder as `/config/Downloads/complete` while Radarr sees that folder as `/downloads`. SABnzbd must use `/downloads/usenet` and Radarr must mount `/hdd-1-4tb/downloads` at `/downloads`.
2. Transmission's downloads not mounted into Radarr/Sonarr. Both need `/hdd-1-4tb/downloads:/downloads`.
3. Category mismatch between the download client and the \*arr. `movies`/`tv` must match on both sides.
4. Retry stuck items: Queue -> circular arrow per item, or Wanted -> Manual Import pointed at `/downloads/usenet/movies` or `/downloads/torrents/movies`.
5. Only if the paths genuinely cannot match, add Settings -> Download Clients -> Remote Path Mapping. Prefer fixing the mounts, Remote Path Mapping hides the problem.

## Fix: Permission Denied On Import

1. `sudo chown -R 1000:1000 /hdd-1-4tb/downloads /hdd-1-4tb/jellyfin/media`
2. `ls -ld /hdd-1-4tb/downloads /hdd-1-4tb/jellyfin/media/movies_german` should show `1000 1000`.
3. `df -T /hdd-1-4tb` should be ext4/xfs/btrfs. NTFS and exFAT have no hardlinks and fake ownership.

## Fix: Imported Files Don't Show Up In Jellyfin

1. Enable real time monitoring on both libraries: Dashboard -> Libraries -> edit -> Enable real time monitoring.
2. Confirm the library folder is `/media/movies_german` and `/media/shows_german`, not `/media`.
3. Manual scan: Dashboard -> Scan All Libraries.
4. Naming comes from Radarr/Sonarr renaming. Keep rename enabled in both.

## Verify

```bash
# imports are hardlinks, not copies (inode numbers must match)
ls -li /hdd-1-4tb/downloads/torrents/movies/*/
ls -li "/hdd-1-4tb/jellyfin/media/movies_german/Big Buck Bunny (2008)/"

# library did not double in size
du -sh /hdd-1-4tb/downloads /hdd-1-4tb/jellyfin/media

# tunnel check
docker exec -it transmission curl ifconfig.me
docker exec -it gluetun curl ifconfig.me

# container status
docker compose ps
```
