#!/bin/sh
mvn clean deploy -P deploy-snapshot
git checkout gh-pages
git add .
git commit -m "added new snapshot files"
git push
git checkout master