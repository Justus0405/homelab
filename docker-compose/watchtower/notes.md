# Watchtower Docker Setup & Configuration

## Discord Notifications

To enable Discord notifications, create a `.env` file with the following variable:

```env
WEBHOOK=discord://<token>@<channel_id>
```

### Converting Your Discord Webhook URL

Your Discord webhook URL looks like this:

```
https://discord.com/api/webhooks/<channel_id>/<token>
```

To convert it into the Watchtower format:

1. Strip the `https://discord.com/api/webhooks/` prefix.
2. Swap the `<channel_id>` and `<token>`.
3. Replace the `/` separator with `@`.
4. Prepend `discord://`.

Example:

```
Original:  https://discord.com/api/webhooks/1423048717547737109/RwSOA9gCA...90_1C1eB
Converted: discord://RwSOA9gCA...90_1C1eB@1423048717547737109
                      ↑ token              ↑ channel ID
```
