#!/bin/bash

./bin/agent42 master master > /dev/null
test $? -eq 0 && echo "✅ pass" || echo "🚫 fail"

./bin/agent42 master some_branch_name  > /dev/null
test $? -ne 0 && echo "✅ pass" || echo "🚫 fail"
