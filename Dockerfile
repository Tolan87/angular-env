FROM alpine:3.7

LABEL author="Toni Langbein"

## Get arguments that can be set by --build-arg (ex. --build-arg NODE=10.0.0)                          ##
## Available node version can be found here: https://nodejs.org/dist/                                  ##
## ARG NODE=8.11.1                                                                                     ##

ENV NODE_VERSION 8.11.1

RUN addgroup -g 1000 node \
    && addgroup -S nginx \
    && adduser -u 1000 -G node -s /bin/sh -D node \
    && adduser -D -S -h /var/tmp/nginx -s /sbin/nologin -G nginx nginx \
    && apk add --no-cache libstdc++ nginx \
    && apk add --no-cache --virtual .dependencies \
    curl \
    gnupg \
    gcc \
    g++ \
    linux-headers \
    make \
    python \
    && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION.tar.xz" \
    && tar -xf "node-v$NODE_VERSION.tar.xz" \
    && cd "node-v$NODE_VERSION" \
    && ./configure && make -j $(($(getconf _NPROCESSORS_ONLN)+1)) && make install \
    && apk del .dependencies \
    && cd .. \
    && rm -Rf "node-v$NODE_VERSION" \
    && rm "node-v$NODE_VERSION.tar.xz" \
    && npm install -g @angular/cli \
    && mkdir -p /run/nginx

COPY /nginx/vhost.conf /etc/nginx/conf.d/default.conf
COPY /nginx/html/* /var/www/localhost/htdocs/

EXPOSE 80

STOPSIGNAL SIGTERM

CMD ["nginx", "-g", "daemon off;"]
