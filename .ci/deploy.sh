#!/usr/bin/env bash

# prepare environment
# this is kinda weird, are you really supposed to check Gemfile.lock into
# version control?
gem install bundler:2.1.4
bundle install || exit 1
git config --global user.name runner

# rebuild the site
bundle exec jekyll build

# set up deploy key
echo $DEPLOY_KEY > deploy.key
chmod 0600 deploy.key
export GIT_SSH_COMMAND="ssh -i $PWD/deploy.key"

# commit changes
git clone git@github.com:jbonhag/jbonhag.github.io /tmp/jbonhag.github.io
rsync -azv --delete --exclude=.git ./_site/ /tmp/jbonhag.github.io
pushd /tmp/jbonhag.github.io
git add .
git commit -m deploy
git push -u origin master
popd

# cleanup
/bin/rm -f deploy.key
/bin/rm -fr /tmp/jbonhag.github.io

# done!
