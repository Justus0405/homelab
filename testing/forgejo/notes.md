# Forgejo Docker Setup & Configuration

## Themes

- Source: https://github.com/whereareiam/forgejo-github-theme

```shell
tar -xzf theme-github-templates.tar.gz -C ./data/gitea
tar -xzf theme-github-fonts.tar.gz -C ./data/gitea/public
tar -xzf theme-github-base.tar.gz -C ./data/gitea/public/assets/css/
tar -xzf theme-github-accessibility.tar.gz -C ./data/gitea/public/assets/css/
tar -xzf theme-github-extras.tar.gz -C ./data/gitea/public/assets/css/
```

/data/gitea/conf/app.ini

```ini
[ui]
DEFAULT_THEME = github-catppuccin-mocha
THEMES = github-catppuccin-mocha
```
