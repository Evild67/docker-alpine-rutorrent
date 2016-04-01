FROM evild/alpine-php

MAINTAINER Dominique HAAS <contact@dominique-haas.fr>

RUN apk add --update rtorrent curl gzip zip unrar supervisor git geoip
RUN git config --global http.sslVerify false \
    && git clone https://github.com/Novik/ruTorrent.git /rutorrent \
    && rm -rf /var/cache/apk/*

COPY supervisord-rtorrent.ini /etc/supervisor.d/supervisord-rtorrent.ini

COPY rtorrent.conf /.rtorrent.rc

ADD root /

EXPOSE 5000 6881 51413
