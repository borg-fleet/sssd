# sssd
A very simple SSSD container intended to be used for borg-fleet.

## Quickstart

```bash
docker run -v ./sssd.conf:/etc/sssd/sssd.conf -v sssd-pipes:/var/lib/sss/pipes ghcr.io/borg-fleet/sssd
```