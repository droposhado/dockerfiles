FROM alpine:3.7

MAINTAINER Flaverton Rodrigues Rosa <flavertonrodrigues@gmail.com>

RUN apk --update add \
    build-base \
    ruby \
    ruby-dev \
    ruby-irb \
    ruby-rdoc \
    nodejs \
    ca-certificates \
    libffi \
    libffi-dev \
    && rm -rf /var/cache/apk/*

VOLUME /src

WORKDIR /src

RUN echo "gem: --no-rdoc --no-ri" >> ~/.gemrc

RUN gem install jekyll bundler --no-document --no-ri \
    && rm -rf /usr/lib/ruby/gems/*/cache/*.gem

EXPOSE 4000