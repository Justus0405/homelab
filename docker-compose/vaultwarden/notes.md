# Vaultwarden Docker Setup & Configuration

## Create Admin Token

- `echo -n 'YourSecurePassword' | argon2 "$(openssl rand -base64 16)" -e -id -k 65536 -t 3 -p 4 | sed 's/\$/\$\$/g'`
