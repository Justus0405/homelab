# SearXNG Docker Setup & Configuration

## Step 1: Add support for Open-WebUI

- Add -json to searchxng/data/settings.yml

```yml
# remove format to deny access, use lower case.
# formats: [html, csv, json, rss]
formats:
  - html
  - json
```

## Step 2: Add a Favicon Resolver

- Add google to searchxng/data/settings.yml

```yml
# backend for the favicon near URL in search results.
# Available resolvers: "allesedv", "duckduckgo", "google", "yandex" - leave blank to turn it off by default.
favicon_resolver: "google"
```

- Create searchxng/data/favicons.toml

```yml
[favicons]

cfg_schema = 1   # config's schema version no.

[favicons.cache]

db_url = "/var/cache/searxng/faviconcache.db"  # default: "/tmp/faviconcache.db"
LIMIT_TOTAL_BYTES = 2147483648                 # 2 GB / default: 50 MB
# HOLD_TIME = 5184000                            # 60 days / default: 30 days
# BLOB_MAX_BYTES = 40960                         # 40 KB / default 20 KB
# MAINTENANCE_MODE = "off"                       # default: "auto"
# MAINTENANCE_PERIOD = 600                       # 10min / default: 1h

[favicons.proxy]

max_age = 5184000             # 60 days / default: 7 days (604800 sec)
```
