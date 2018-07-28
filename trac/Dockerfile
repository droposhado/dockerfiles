FROM alpine:3.7

MAINTAINER Flaverton Rodrigues Rosa <flavertonrodrigues@gmail.com>

ENV TRAC_VERSION 1.2.2

# New trac plugins must be added to this base image and not later,
# this ensures that the image is small and has fewer packages installed.
RUN apk update && \
    apk --update add \
    build-base \
    curl \
    openssl \
    python2 \
    python2-dev \
    py2-pip && \
    rm -rf /var/cache/apk/* && \
    cd $HOME && \
    curl -sL https://github.com/edgewall/trac/archive/trac-$TRAC_VERSION.zip -o $HOME/trac-$TRAC_VERSION.zip && \
    unzip trac-$TRAC_VERSION.zip && \
    cd trac-trac-$TRAC_VERSION/ && \
    python ./setup.py install_lib && \
    rm -Rf $HOME/trac-$TRAC_VERSION/ && \
    pip install -U \
    pip \
    pytz \
    gunicorn \
    docutils && \
    apk del \
    build-base \
    openssl \
    python2-dev

WORKDIR /var/trac
#VOLUME /var/trac

COPY wsgi.py /var/trac
COPY docker-entrypoint.sh /var/trac

EXPOSE 9000

# ENTRYPOINT ["trac-admin"]
# CMD ["docker-entrypoint.sh"]

ENTRYPOINT ["/var/trac/docker-entrypoint.sh"]
