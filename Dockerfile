# Dockerfile - alpine
# https://github.com/openresty/docker-openresty

ARG RESTY_IMAGE_BASE="alpine"
ARG RESTY_IMAGE_TAG="3.8"

FROM ${RESTY_IMAGE_BASE}:${RESTY_IMAGE_TAG}

# Docker Build Arguments
ARG RESTY_VERSION="1.15.8.1"
ARG RESTY_LUAROCKS_VERSION="3.1.3"
ARG RESTY_OPENSSL_VERSION="1.1.1c"
ARG RESTY_PCRE_VERSION="8.41"

RUN apk add --no-cache bsd-compat-headers \
        linux-headers \
        coreutils \
        curl \
        perl \
        build-base \
        m4 \
        yaml-dev \
        git \
        bash \
        valgrind-dev \
        zlib-dev \
        unzip \
        openssl-dev

RUN git clone https://github.com/Kong/openresty-build-tools.git

RUN cd openresty-build-tools && ./kong-ngx-build -p buildroot --openresty $RESTY_VERSION --openssl $RESTY_OPENSSL_VERSION --luarocks $RESTY_LUAROCKS_VERSION --pcre $RESTY_PCRE_VERSION

RUN ln -s /openresty-build-tools/buildroot/luarocks/bin/luarocks /usr/local/bin/luarocks
RUN ln -s /openresty-build-tools/buildroot/openresty/bin/resty /usr/local/bin/resty
RUN ln -s /openresty-build-tools/buildroot/openresty/nginx/sbin/nginx /usr/local/bin/nginx
