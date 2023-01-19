FROM ubuntu:22.04

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends --yes sssd
RUN chown -R sssd:sssd /var/lib/sss

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sssd", "-i", "-d", "4" ]
