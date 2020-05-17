#!/usr/bin/env bash

# fetch the existing site
if [ -d /tmp/jbonhag.github.io ]; then
  /bin/rm -fr /tmp/jbonhag.github.io
fi
git clone git@github.com:jbonhag/jbonhag.github.io /tmp/jbonhag.github.io

# rebuild the site
jekyll build

# commit changes
rsync -azv --delete --exclude=.git /Users/jeff/Documents/blog/_site/ /tmp/jbonhag.github.io
pushd /tmp/jbonhag.github.io
git add .
git commit -m deploy
git push -u origin master

# done!
