# SearchXNG Docker Setup & Configuration

## Add support for Open-WebUI Web Search Engine

- Add -json to searchxng/data/settings.yml

```yml
# remove format to deny access, use lower case.
# formats: [html, csv, json, rss]
formats:
  - html
  - json
```
