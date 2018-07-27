FROM alpine:3.7

MAINTAINER Flaverton Rodrigues Rosa <flavertonrodrigues@gmail.com>

ENV TRAC_ENV /var/trac
ENV TRAC_VERSION 1.2.2

RUN apk --update add \
    build-base \
    curl \
    openssl \
    python2 \
    python2-dev \
    py2-pip \
    && rm -rf /var/cache/apk/*

RUN cd $HOME && \
  curl -sL https://github.com/edgewall/trac/archive/trac-$TRAC_VERSION.zip -o $HOME/trac-$TRAC_VERSION.zip && \
  unzip trac-$TRAC_VERSION.zip && \
  cd trac-trac-$TRAC_VERSION/ && \
  python ./setup.py install_lib && \
  rm -Rf $HOME/trac-$TRAC_VERSION/

# https://trac.edgewall.org/browser/trunk/INSTALL.rst
# RUN pip install -u \
#   pytz \
#   textile \
#   https://github.com/edgewall/trac/archive/trac-$TRAC_VERSION.zip

RUN pip install -U \
  pip \
  pytz \
  gunicorn \
  docutils

WORKDIR $TRAC_ENV
VOLUME $TRAC_ENV

COPY wsgi.py $TRAC_ENV
COPY docker-entrypoint.sh $TRAC_ENV

EXPOSE 9000

ENTRYPOINT ["trac-admin"]
CMD ["docker-entrypoint.sh"]
