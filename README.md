# sssd
A very simple SSSD container intended to be used for borg-fleet.

## Quickstart

```bash
docker run -e "SSSD_CONF=<content of sssd.conf here>" -v sssd-pipes:/var/lib/sss/pipes:rw ghcr.io/borg-fleet/sssd
```

Other containers that have SSSD installed can query SSSD via volume:

```bash
docker run -v sssd-pipes:/var/lib/sss/pipes:ro <my-image-here>
```
