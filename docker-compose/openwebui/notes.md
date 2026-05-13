# Open-WebUI Docker Setup & Configuration

## Sources

- https://docs.openwebui.com/features/chat-conversations/web-search/agentic-search/

## Step 1: SearXNG Add support for Web Search Engine

- Add -json to searchxng/data/settings.yml

```yml
# remove format to deny access, use lower case.
# formats: [html, csv, json, rss]
formats:
  - html
  - json
```

## Step 2: Add the values

- Admin Panel → Settings → Web Search

### General

- Web Search: true
- Web Search Engine: searxng
- Searxng Query URL: http://192.168.178.100:3081/search?q=<query>
- Searxng search language (all, en, es, de, fr, etc.): all
- Search Result Count: 10
- Concurrent Requests: 0
- Fetch URL Content Length Limit: 16000
- Domain Filter List: none
- Bypass Embedding and Retrieval: false (Set to true for quality increase but increases token amount too)
- Bypass Web Loader: false
- Trust Proxy Environment: true

### Loader

- Web Loader Engine: playwright
- Playwright WebSocket URL: ws://192.168.178.100:3082
- Playwright Timeout (ms): 30000
- Concurrent Requests: 10

### Step 3: Enable Web Search & native Agentic tool calling by Default

- Admin Panel → Settings → Models → Settings (top left) → Model Capabilities → Enable Web Search
- Admin Panel → Settings → Models → Settings (top left) → Model Parameters → Function Calling from Default → Native

### Step 4: Upgrade Embeddings Model (OPTIONAL) (NOT GENERALLY RECOMMENDED)

- Admin Panel → Settings → Documents → Embedding

- Embedding Model Engine: OpenAI → https://openrouter.ai/api/v1
- Embedding Model: openai/text-embedding-3-large

## Fix: Playwright version mismatch

- Make sure line 37 (Playwright launch command) and line 33 (Docker Image version) match the CLIENT version!

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
