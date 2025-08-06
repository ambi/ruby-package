# README

```shell
docker build -t rocky9-rbenv:3.4.5 .
docker run -it --rm -v ./:/app -v .bundle rocky9-rbenv:3.4.5 /bin/bash
```

```shell
cd /app
echo 'gem: --no-document' > /etc/.gemrc
bundle config set --local path vendor/bundle
bundle config set deployment true
bundle config set without 'development test'
bundle install
bundle package
RAILS_ENV=production ./bin/rails assets:precompile
# bundle exec bootsnap precompile app/ lib/
# RAILS_ENV=production bundle exec rake assets:precompile

# gem install fpm
# APP_NAME=app
# APP_VERSION=1.0.0
# fpm -s dir -t rpm -n "${APP_NAME}" -v "${APP_VERSION}" --rpm-os linux --exclude="opt/${APP_NAME}/${APP_VERSION}/.git" --exclude='opt/rbenv/.git' --exclude='opt/rbenv/plugins/ruby-build/.git' --exclude="opt/${APP_NAME}/${APP_VERSION}/tmp" --exclude="opt/${APP_NAME}/${APP_VERSION}/log" --exclude "${APP_NAME}-*.rpm" /opt/rbenv "/app=/opt/${APP_NAME}/${APP_VERSION}"
```
