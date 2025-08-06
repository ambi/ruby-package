# syntax=docker/dockerfile:1
# check=error=true

ARG RUBY_VERSION=3.4.5
ARG APP_NAME=app
ARG APP_VERSION=1.0.0

FROM rockylinux:9 AS rbenv

RUN dnf -y install epel-release && \
    dnf config-manager --set-enabled crb && \
    dnf -y install git gcc openssl-devel libyaml-devel libffi-devel zlib-devel rpm-build

ENV RBENV_ROOT=/opt/rbenv
ENV PATH=${RBENV_ROOT}/shims:${RBENV_ROOT}/bin:$PATH
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} && \
    git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build && \
    rbenv install 3.4.5 && \
    rbenv global 3.4.5

# FROM rbenv AS app

# WORKDIR /app
# RUN bundle config set --local path vendor/bundle && \
#     bundle config set deployment true && \
#     bundle config set without 'development test' && \
#     bundle install && \
#     SECRET_KEY_BASE_DUMMY=1 ./bin/rails assets:precompile
# # bundle exec bootsnap precompile app/ lib/
# # RAILS_ENV=production bundle exec rake assets:precompile

# FROM app AS rpm

# WORKDIR /app
# RUN gem install --no-document fpm && \
#     fpm -s dir -t rpm -n "${APP_NAME}-${APP_VERSION}" -v "${APP_VERSION}" --rpm-os linux /opt/rbenv "/app=/opt/${APP_NAME}/${APP_VERSION}"
