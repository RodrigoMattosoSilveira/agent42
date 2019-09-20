#!/bin/bash

BRANCH="master"
./bin/agent42 master $BRANCH > /dev/null
test $? -eq 0 && echo "✅ pass master"$BRANCH "is master" || echo "🚫 fail master"$BRANCH "is not master"

BRANCH="some_branch_name"
./bin/agent42 master some_branch_name  > /dev/null
test $? -eq 1 && echo "✅ pass master"$BRANCH "is not master" || echo "🚫  master"$BRANCH " is master"

VERSION="1.40.0-alpha.1"
./bin/agent42 feature $VERSION > /dev/null
test $? -eq 0 && echo "✅ pass feature "$VERSION "is a feature version" || echo "🚫 fail feature "$VERSION "is not a feature version"

VERSION="1.40.0"
./bin/agent42 feature $VERSION  > /dev/null
test $? -eq 1 && echo "✅ pass feature "$VERSION "is not a feature version" || echo "🚫 fail feature "$VERSION "is a feature version"

PULL_REQUEST=false
VERSION=1.40.0
./bin/agent42 tag $PULL_REQUEST $VERSION  > /dev/null
test $? -eq 0 && echo "✅ pass tag "$PULL_REQUEST "is not a pull request build" || echo "🚫 fail tag "$PULL_REQUEST "is a pull request build"

PULL_REQUEST=42
VERSION=0.0.2
./bin/agent42 tag $PULL_REQUEST $VERSION  > /dev/null
test $? -eq 1 && echo "✅ pass tag "$VERSION "does not match CHANGELOG" || echo "🚫 fail tag "$VERSION "matches CHANGELOG"

PULL_REQUEST=42
VERSION=0.0.1
./bin/agent42 tag $PULL_REQUEST $VERSION  > /dev/null
test $? -eq 2 && echo "✅ pass tag v"$VERSION "already exists" || echo "🚫 fail tag v"$VERSION "does not exist"

rm -rf CHANGELOG.md.sav
mv CHANGELOG.md CHANGELOG.md.sav
cp spec/CHANGELOG.md.test CHANGELOG.md
PULL_REQUEST=42
VERSION=0.0.2
./bin/agent42 tag $PULL_REQUEST $VERSION  > /dev/null
test $? -eq 0 && echo "✅ pass tag Pull request introduces version v$VERSION" || echo "🚫 fail tag Pull request did not introduce version v$VERSIO"
rm -rf CHANGELOG.md
mv CHANGELOG.md.sav CHANGELOG.md
