ARG ubuntu_version
FROM ubuntu:${ubuntu_version}

RUN apt-get update && apt-get install --no-install-recommends --yes sssd
CMD ["/usr/sbin/sssd","-i","-d","4"]
