#!/usr/bin/env bash
set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

cd "${SCRIPT_DIR}"

echo "Starting test setup..."
docker-compose up -d


echo "Wait for LDAP to become online..."
SECONDS=0
until exec 3<>/dev/tcp/localhost/389
do
  if (( SECONDS > 60 ))
  then
     echo "Giving up..."
     exit 1
  fi
  echo "LDAP is not up yet. Waiting..."
  sleep 2
done

echo "Waiting for SSSD to find LDAP..."
SECONDS=0
until docker logs test_sssd_1 2>&1 | grep -q "Marking port 389 of server 'ldap' as 'working'"
do
  if (( SECONDS > 180 ))
  then
     echo "Giving up..."
     exit 1
  fi
  echo "SSSD has not found LDAP yet. Waiting..."
  sleep 10
done

sleep 1

echo "Test: User billy should exist in SSSD container..."
docker exec test_sssd_1 getent passwd billy

echo "Test: User billy should have corrent ssh key in SSSD container..."
docker exec test_sssd_1 /usr/bin/sss_ssh_authorizedkeys billy | grep -q 'ssh-rsa ABC'

echo "Test: User billy should exist in SSSD client container..."
docker exec test_sssd-client_1 getent passwd billy

echo "Test: User billy should have corrent ssh key in SSSD client container..."
docker exec test_sssd-client_1 /usr/bin/sss_ssh_authorizedkeys billy | grep -q 'ssh-rsa ABC'

echo "TESTS PASSED"
