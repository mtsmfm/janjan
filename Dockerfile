FROM ruby:2.3.1
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -qq && \
  apt-get install -y less postgresql-client-9.5

# https://github.com/docker-library/postgres/blob/b2317dd369030a5f3f030b1daa1fc80da3cab9e0/9.6/Dockerfile#L8
ENV GOSU_VERSION 1.7
RUN set -x \
	&& apt-get update && apt-get install -y --no-install-recommends ca-certificates wget && rm -rf /var/lib/apt/lists/* \
	&& wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture)" \
	&& wget -O /usr/local/bin/gosu.asc "https://github.com/tianon/gosu/releases/download/$GOSU_VERSION/gosu-$(dpkg --print-architecture).asc" \
	&& export GNUPGHOME="$(mktemp -d)" \
	&& gpg --keyserver ha.pool.sks-keyservers.net --recv-keys B42F6819007F00F88E364FD4036A9C25BF357DD4 \
	&& gpg --batch --verify /usr/local/bin/gosu.asc /usr/local/bin/gosu \
	&& rm -r "$GNUPGHOME" /usr/local/bin/gosu.asc \
	&& chmod +x /usr/local/bin/gosu \
	&& gosu nobody true

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

ARG RAILS_ENV=production
ARG APP_DIR=/app
ARG APP_USER=app
ARG APP_UID=1000
RUN useradd --create-home --user-group --uid $APP_UID $APP_USER

ENV RAILS_ENV=$RAILS_ENV
ENV RACK_ENV=$RAILS_ENV
ENV RAILS_SERVE_STATIC_FILES=enabled
ENV BUNDLE_PATH=$APP_DIR/vendor/bundle
ENV BUNDLE_JOBS=4
ENV RAILS_LOG_TO_STDOUT=enabled
ENV RAILS_SERVE_STATIC_FILES=enabled
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8
ENV APP_DIR=$APP_DIR
ENV APP_USER=$APP_USER

EXPOSE 3000

WORKDIR $APP_DIR

COPY Gemfile* ./

RUN if [ "$RAILS_ENV" = "production" ]; then \
  bundle install --without development:test \
;fi

COPY . .

RUN if [ "$RAILS_ENV" = "production" ]; then \
  bin/rails assets:precompile \
;fi

ENTRYPOINT ["./docker-entrypoint.sh"]
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
