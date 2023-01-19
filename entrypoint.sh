#!/bin/bash
set -e

echo "${SSSD_CONF}" > /etc/sssd/sssd.conf

# fix permissions
chmod 600 /etc/sssd/sssd.conf

# create db directory if not exists
mkdir -p /var/lib/sss/db
mkdir -p /var/lib/sss/pipes/private
mkdir -p /var/lib/sss/mc

exec "$@"
