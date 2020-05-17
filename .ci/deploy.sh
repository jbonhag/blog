#!/usr/bin/env bash

# prepare environment
# this is kinda weird, are you really supposed to check Gemfile.lock into
# version controler?
sed -e '1,/BUNDLED WITH/d' Gemfile.lock | read BUNDLER_VERSION
gem install bundler:${BUNDLER_VERSION}
bundle install || exit 1

# rebuild the site
bundle exec jekyll build

# commit changes
if [ -d /tmp/jbonhag.github.io ]; then
  /bin/rm -fr /tmp/jbonhag.github.io
fi
git clone git@github.com:jbonhag/jbonhag.github.io /tmp/jbonhag.github.io
rsync -azv --delete --exclude=.git /Users/jeff/Documents/blog/_site/ /tmp/jbonhag.github.io
pushd /tmp/jbonhag.github.io
git add .
git commit -m deploy
git push -u origin master

# done!
