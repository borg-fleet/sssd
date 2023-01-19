FROM ubuntu:22.04

ADD entrypoint.sh /entrypoint.sh

RUN apt-get update && apt-get install --no-install-recommends --yes sssd
RUN chown -R sssd:sssd /var/lib/sss

ENTRYPOINT [ "/entrypoint.sh" ]
CMD [ "/usr/sbin/sssd", "-i", "-d", "4" ]
