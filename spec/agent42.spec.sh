#!/bin/bash

BRANCH="master"
./bin/agent42 master $BRANCH > /dev/null
test $? -eq 0 && echo "✅ pass master"$BRANCH "is master" || echo "🚫 fail master"$BRANCH "is not master"

BRANCH="some_branch_name"
./bin/agent42 master some_branch_name  > /dev/null
test $? -ne 0 && echo "✅ pass master"$BRANCH "is not master" || echo "🚫  master"$BRANCH " is master"

VERSION="1.40.0-alpha.1"
./bin/agent42 feature $VERSION > /dev/null
test $? -eq 0 && echo "✅ pass feature "$VERSION "is a feature version" || echo "🚫 fail feature "$VERSION "is not a feature version"

VERSION="1.40.0"
./bin/agent42 feature $VERSION  > /dev/null
test $? -ne 0 && echo "✅ pass feature "$VERSION "is not a feature version"|| echo "🚫 fail feature "$VERSION "is a feature version"
