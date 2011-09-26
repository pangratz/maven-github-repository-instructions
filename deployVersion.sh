#!/bin/sh
mvn release:clean release:prepare
mvn release:perform
git checkout gh-pages
git add .
git commit -m "added new version files"
git push
git checkout master