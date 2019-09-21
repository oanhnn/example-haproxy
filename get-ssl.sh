#!/bin/bash

DOMAINS=${1:-"example.com"}
EMAIL=${2:-"admin@example.com"}

# Get first domain in domain list
IFS=',' read -ra DOMAIN_ARRAY <<< "${DOMAINS}"
DOMAIN="${DOMAIN_ARRAY[0]}"

set -aux

mkdir ssl

if [[ -f ssl/live/${DOMAIN}/privkey.pem ]]; then
    docker run --rm -it -p 80:80 -v $(pwd)/ssl:/etc/letsencrypt certbot/certbot \
        certonly renew
else
    docker run --rm -it -p 80:80 -v $(pwd)/ssl:/etc/letsencrypt certbot/certbot \
        certonly --standalone -n --agree-tos -d ${DOMAINS} -m ${EMAIL}
fi

cat ssl/live/${DOMAIN}/fullchain.pem ssl/live/${DOMAIN}/privkey.pem | tee ${DOMAIN}.pem
