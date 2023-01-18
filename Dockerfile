FROM ubuntu:22.04

RUN apt-get update && apt-get install --no-install-recommends --yes sssd
CMD ["/usr/sbin/sssd","-i","-d","4"]
