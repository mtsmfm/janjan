FROM ruby:2.3.1
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list \
  && wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - \
  && apt-get update -qq \
  && apt-get install -y less postgresql-client-9.5

# https://github.com/nodejs/docker-node/blob/4029a8f71920e1e23efa79602167014f9c325ba0/6.7/Dockerfile
RUN set -ex \
  && for key in \
    9554F04D7259F04124DE6B476D5A82AC7E37093B \
    94AE36675C464D64BAFA68DD7434390BDBE9B9C5 \
    0034A06D9D9B0064CE8ADF6BF1747F4AD2306D93 \
    FD3A5288F042B6850C66B31F09FE44734EB7990E \
    71DCFD284A79C3B38668286BC97EC7A07EDE3FC1 \
    DD8F2338BAE7501E3DD5AC78C273792F7D83545D \
    B9AE9905FFD7803F25714661B63B535A4C206CA9 \
    C4F0DFFF4E8C1A8236409D08E73BC641CC11F4C8 \
  ; do \
    gpg --keyserver ha.pool.sks-keyservers.net --recv-keys "$key"; \
  done

ENV NODE_VERSION 6.7.0

RUN curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.xz" \
  && curl -SLO "https://nodejs.org/dist/v$NODE_VERSION/SHASUMS256.txt.asc" \
  && gpg --batch --decrypt --output SHASUMS256.txt SHASUMS256.txt.asc \
  && grep " node-v$NODE_VERSION-linux-x64.tar.xz\$" SHASUMS256.txt | sha256sum -c - \
  && tar -xJf "node-v$NODE_VERSION-linux-x64.tar.xz" -C /usr/local --strip-components=1 \
  && rm "node-v$NODE_VERSION-linux-x64.tar.xz" SHASUMS256.txt.asc SHASUMS256.txt \
  && ln -s /usr/local/bin/node /usr/local/bin/nodejs

ENV YARN_VERSION 0.16.1

RUN npm install -g yarn@$YARN_VERSION

ARG RAILS_ENV=production
ARG APP_DIR=/app
ARG APP_USER=app
ARG APP_UID=1000
ARG LOCAL_BUILD=
RUN useradd --create-home --user-group --uid $APP_UID $APP_USER

ENV BUNDLE_PATH=$APP_DIR/vendor/bundle \
  BUNDLE_JOBS=4 \
  RAILS_LOG_TO_STDOUT=enabled \
  RAILS_SERVE_STATIC_FILES=enabled \
  LANG=C.UTF-8 \
  LC_ALL=C.UTF-8 \
  APP_DIR=$APP_DIR \
  APP_USER=$APP_USER \
  LOCAL_BUILD=$LOCAL_BUILD

WORKDIR $APP_DIR

COPY Gemfile* ./
RUN chown -R $APP_USER $APP_DIR
USER $APP_USER
RUN if [ -z "$LOCAL_BUILD" ]; then \
  bundle install \
;fi

COPY . .
USER root
RUN chown -R $APP_USER $APP_DIR
USER $APP_USER
RUN if [ -z "$LOCAL_BUILD" ]; then \
  yarn install \
  && RAILS_ENV=production bin/rails assets:precompile \
;fi

CMD ["bin/rails", "server"]
