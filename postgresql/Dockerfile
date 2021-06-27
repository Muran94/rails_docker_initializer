# BASE
FROM ruby:3.0.1-alpine3.13 as base
ARG bundle_jobs
ARG bundle_without
WORKDIR /app
ENV LANG=ja_JP.UTF-8 \
    TZ=Asia/Tokyo \
    BUNDLE_JOBS=$bundle_jobs \
    BUNDLE_WITHOUT=$bundle_without
RUN apk update && \
    apk add --no-cache postgresql tzdata yarn nodejs && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    apk del --purge tzdata



# GEMS
FROM base as gems
RUN apk add --no-cache --virtual for-bundle-install build-base git postgresql-dev
COPY Gemfile* ./
RUN bundle install && \
    rm -rf /usr/local/bundle/cache/*.gem && \
    find /usr/local/bundle/gems/ -name "*.c" -delete && \
    find /usr/local/bundle/gems/ -name "*.o" -delete && \
    find /usr/local/bundle/gems/ -path '/*/ext/*/Makefile' -exec dirname {} \; | xargs -n1 -P$(nproc) -I{} make -C {} clean && \
    apk del --purge for-bundle-install



# YARN
FROM base as yarn
RUN apk add --no-cache --virtual for-yarn-install python2 make g++
COPY package.json yarn.lock ./
RUN yarn install --check-files && \
    yarn cache clean && \
    apk del --purge for-yarn-install



# BASE APP
FROM base as base-app
COPY . .
COPY --from=yarn /app/yarn.lock yarn.lock
COPY --from=gems /usr/local/bundle /usr/local/bundle



# APP FOR DEVELOPMENT AND TEST
FROM base-app as app-for-development-and-test
RUN apk add --no-cache less bash vim



# APP FOR PRODUCTION
FROM base-app as app-for-production
ENV RAILS_ENV=production \
    RACK_ENV=production \
    RAILS_LOG_TO_STDOUT=enabled \
    RAILS_SERVE_STATIC_FILES=enabled \
    SECRET_KEY_BASE=dummy
COPY --from=yarn /app/node_modules node_modules
RUN rails assets:precompile
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]