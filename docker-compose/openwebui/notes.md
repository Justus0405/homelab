# Open-WebUI Docker Setup & Configuration

## Add support for Web Search Engine

- Add -json to searchxng/data/settings.yml

```yml
# remove format to deny access, use lower case.
# formats: [html, csv, json, rss]
formats:
  - html
  - json
```

## Fix Playwright version mismatch:

```log
fastapi.exceptions.HTTPException: 400: [ERROR: BrowserType.connect: WebSocket error: ws://192.168.178.100:3082/ 428 Precondition Required
╔════════════════════════════════════════════════════╗
║ Playwright version mismatch:                       ║
║   - server version: v1.54                          ║
║   - client version: v1.58                          ║
║                                                    ║
║ If you are using VSCode extension, restart VSCode. ║
║                                                    ║
║ If you are connecting to a remote service,         ║
║ keep your local Playwright version in sync         ║
║ with the remote service version.                   ║
║                                                    ║
║ <3 Playwright Team                                 ║
╚════════════════════════════════════════════════════╝
```

- Make sure line 37 (Playwright launch command) and line 33 (Docker Image version) match the CLIENT version!

## Legacy Notes

```yaml
environment:
  # Public
  WEBUI_URL: "https://openwebui.justus0405.com"
  ENABLE_SIGNUP: "false"
  DEFAULT_USER_ROLE: "pending"

  # Security
  WEBUI_SECRET_KEY: "${WEBUI_SECRET_KEY}" # openssl rand -hex 32
  ENV: "prod"
  WEBUI_SESSION_COOKIE_SECURE: "true"
  WEBUI_AUTH_COOKIE_SECURE: "true"
  WEBUI_SESSION_COOKIE_SAME_SITE: "lax"
  WEBUI_AUTH_COOKIE_SAME_SITE: "lax"
  ENABLE_PASSWORD_VALIDATION: "true"
  PASSWORD_VALIDATION_HINT: "Min 8 chars, with uppercase, lowercase, number, and symbol."
  JWT_EXPIRES_IN: "7d"
  ENABLE_PUBLIC_ACTIVE_USERS_COUNT: "false"
  ENABLE_COMMUNITY_SHARING: "false"

  # Web Search
  ENABLE_WEB_SEARCH: "true"
  WEB_SEARCH_ENGINE: "searxng"
  SEARXNG_QUERY_URL: "http://192.168.178.100:3081/search?q=<query>"
  SEARXNG_SEARCH_LANGUAGE: "all"
  WEB_SEARCH_RESULT_COUNT: "5"
  WEB_SEARCH_CONCURRENT_REQUESTS: "0"
  BYPASS_WEB_SEARCH_EMBEDDING_AND_RETRIEVAL: "false"
  BYPASS_WEB_SEARCH_WEB_LOADER: "false"
  WEB_SEARCH_TRUST_ENV: "true"

  # Playwright
  WEB_LOADER_ENGINE: "playwright"
  PLAYWRIGHT_WS_URL: "ws://192.168.178.100:3082"
  PLAYWRIGHT_TIMEOUT: "30000"
  WEB_LOADER_CONCURRENT_REQUESTS: "10"
```
