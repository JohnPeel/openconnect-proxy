FROM haproxy:alpine
MAINTAINER John Peel "john@dgby.org"

# Adding s6-overlay
ADD https://github.com/just-containers/s6-overlay/releases/download/v1.21.7.0/s6-overlay-amd64.tar.gz /tmp/
RUN gunzip -c /tmp/s6-overlay-amd64.tar.gz | tar -xf - -C /

# Install openconnect and vpnc
RUN apk add openconnect vpnc --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
 && echo "hosts: files dns" > /etc/nsswitch.conf

COPY haproxy-run /etc/services.d/haproxy/run
COPY openconnect-run /etc/services.d/openconnect/run

VOLUME /conf

EXPOSE 1521
ENTRYPOINT ["/init"]
