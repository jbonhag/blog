#!/usr/bin/env bash

# prepare environment
# this is kinda weird, are you really supposed to check Gemfile.lock into
# version control?
gem install bundler:2.1.4
bundle install || exit 1
git config --global user.name runner

# rebuild the site
bundle exec jekyll build

# commit changes
if [ -d /tmp/jbonhag.github.io ]; then
  /bin/rm -fr /tmp/jbonhag.github.io
fi
git clone git@github.com:jbonhag/jbonhag.github.io /tmp/jbonhag.github.io
rsync -azv --delete --exclude=.git ./_site/ /tmp/jbonhag.github.io
pushd /tmp/jbonhag.github.io
git add .
git commit -m deploy
git push -u origin master

# done!
