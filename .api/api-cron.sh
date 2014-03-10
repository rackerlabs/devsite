#!/bin/bash

DATE=`date +"%Y-%m-%d"`
BRANCH=api-$DATE

cd /home/apiref/devsite
git checkout master
git pull
git checkout -b $BRANCH

cd /home/apiref
cp api-ref/target/docbkx/html/ /home/apiref/devsite/source/api/*.*

cd /home/apiref/devsite

CHANGES=`git diff-index --name-only HEAD --`
if [ -n "$CHANGED" ]; then
  git checkout master
  git branch --delete $BRANCH
else
  MESSAGE="API reference update for $DATE"
  git add .
  git commit -m "$MESSAGE"
  git push -u origin $BRANCH
  hub pull-request -m "$MESSAGE"
fi
