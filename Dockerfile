FROM ezkrg/geoipupdate:latest

ENV VERSION=1.3.2

RUN apk add --update --no-cache --virtual .build-deps \
        build-base \
        git \
        automake \
        autoconf \
        libtool \
 && cd /tmp \
 && git clone -b ${VERSION} --recursive https://github.com/maxmind/libmaxminddb.git \
 && cd libmaxminddb \
 && sh ./bootstrap \
 && ./configure \
 && make \
 && make check \
 && make install-exec \
 && rm -rf /tmp/* \
 && apk del .build-deps \
 && rm -rf /var/cache/apk/*