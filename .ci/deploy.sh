#!/usr/bin/env bash

# prepare environment
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
