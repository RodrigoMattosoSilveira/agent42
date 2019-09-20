#!/bin/bash

# Usage
# tag pull_request (Y/N) package_version

tag() {
  echo "tag - pull_request: "$1
  echo "tag - package_version: "$2
  if [[$1 -eq false ]]; then
    echo "✅ Not a pull request build"
    return 0;
  fi
  #package_version=`npx -c 'echo "$npm_package_version"'`
  changelog_version=`sed -nE 's/## \[([0-9]+(\.[0-9]+)+)\]( +- +[0-9]+-[0-9]+-[0-9]+)?/\1/p' CHANGELOG.md | head -n 1`
  if [[ $2 != ${changelog_version} ]]; then
      echo "🚫 Versions in package.json ($2) and CHANGELOG.md (${changelog_version}) are different"
      return 1
  fi
  if git ls-remote -q --tags | grep -q "v$2$"; then
      echo "🚫 Tag already exists for version $2"
      return 2
  fi
  echo "✅ Pull request introduces version $2"
  return 0;
}
