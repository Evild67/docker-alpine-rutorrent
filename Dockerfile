FROM evild/alpine-php

MAINTAINER Dominique HAAS <contact@dominique-haas.fr>

RUN apk add --update rtorrent curl gzip zip unrar supervisor git geoip
RUN git config --global http.sslVerify false \
    && git clone https://github.com/Novik/ruTorrent.git /rutorrent \
    && mkdir -p /downloads/incoming /downloads/completed /downloads/watched /downloads/sessions /tmp/rtorrent \
    && adduser -D -h / -u 5001 rtorrent \
    && chown -R www-data:www-data /downloads /rutorrent /tmp/rtorrent\
    && sed -i \
        -e "/curl/ s/''/'\/usr\/bin\/curl'/" \
        /rutorrent/conf/config.php \
    && rm -rf /var/cache/apk/*

COPY supervisord-rtorrent.ini /etc/supervisor.d/supervisord-rtorrent.ini

COPY rtorrent.conf /.rtorrent.rc

VOLUME /downloads /rutorrent

EXPOSE 5000 6881 51413

CMD ["supervisord", "-c", "/etc/supervisord.conf", "-n"]
