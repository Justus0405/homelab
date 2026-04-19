# Jellyfin Docker Setup & Configuration

## Setup Notes

1. Ensure all volume directories exist before starting the container.
2. For Intel iGPU support, install the `intel-gpu-tools` package.
3. Set the correct group ID for `/dev/dri/renderD128`:
   - Check ownership: `ls -l /dev/dri`
   - Get the group ID (e.g. `render`): `getent group render | cut -d: -f3`
4. Verify QuickSync functionality:
   ```bash
   docker exec -it jellyfin /usr/lib/jellyfin-ffmpeg/vainfo
   ```

Optional: Disable quick login, enable transcoding, and set player limit to 8 Mbps.

## Fix: No Collection Thumbnails

1. Install the TMDb Box Sets plugin (Dashboard -> Plugins).
2. Restart Jellyfin: `docker restart jellyfin`
3. Rebuild Box Sets: Dashboard -> Scheduled Tasks -> Run Scan library for new box sets.
4. Rescan Collections: Dashboard -> Library -> Collections -> Trigger Scan.

## Cool Look

Plugins:

1. Add repository: `https://www.iamparadox.dev/jellyfin/plugins/manifest.json`
2. Install File Transformation
3. Install Media Bar

Theme (paste into Dashboard -> Branding -> Custom CSS):

```css
@import url("https://cdn.jsdelivr.net/gh/loof2736/scyfin@latest/CSS/scyfin-theme.css");
@import url("https://cdn.jsdelivr.net/gh/loof2736/scyfin@latest/CSS/disable-static-drawer.css");
```

Restart Jellyfin after applying: `docker restart jellyfin`

## Libraries

| Anime Movies           | Anime Shows           | Movies           | Shows           |
| ---------------------- | --------------------- | ---------------- | --------------- |
| `anime_movies_english` | `anime_shows_english` | `movies_english` | `shows_english` |
| `anime_movies_german`  | `anime_shows_german`  | `movies_german`  | `shows_german`  |

---

## Plugin List

- Fanart
- TMDb Box Sets
- Media Bar
- File Transformation
