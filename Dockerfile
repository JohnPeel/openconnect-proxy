FROM haproxy:alpine
MAINTAINER John Peel "john@dgby.org"

ADD http://git.infradead.org/users/dwmw2/vpnc-scripts.git/blob_plain/HEAD:/vpnc-script /vpnc-script

RUN apk add openconnect --no-cache --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ --allow-untrusted \
    && chmod +x /vpnc-script \
    && echo "hosts: files dns" > /etc/nsswitch.conf

COPY docker-entrypoint.sh /
COPY haproxy.cfg /usr/local/etc/haproxy/haproxy.cfg

EXPOSE 1521
