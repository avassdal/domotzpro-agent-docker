FROM ubuntu:latest

LABEL maintainer="aleksander@ekkotek.no"

EXPOSE 3000

ADD https://portal.domotz.com/download/agent_packages/domotz-raspberry-arm64-1.0-2.9.9-4.5.3-b003-0104.deb /root/

RUN apt-get update && apt-get install -y --no-install-recommends ca-certificates iputils-ping net-tools iproute2 openssh-client

RUN printf "#!/bin/sh\necho N 2" > /sbin/runlevel \
 && chmod +x /sbin/runlevel \
 && printf "#!/bin/sh\nexit 0" > /usr/sbin/policy-rc.d \
 && chmod +x /usr/sbin/policy-rc.d \
 && dpkg -i /root/domotz-raspberry-arm64*.deb \
 && rm /root/domotz-raspberry-arm64*.deb \
 && rm -rf /var/lib/apt/lists/*

RUN sed -i 's/raspberry/docker/g' /opt/domotz/etc/domotz.env

RUN mkdir /opt/utils
COPY runme.sh /opt/utils

CMD service domotz start \
 && /opt/utils/runme.sh
