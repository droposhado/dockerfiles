FROM alpine:3.7

MAINTAINER Flaverton Rodrigues Rosa <flavertonrodrigues@gmail.com>

RUN apk --update add \
    nodejs \
    && rm -rf /var/cache/apk/*

RUN npm install -g gitbook-cli