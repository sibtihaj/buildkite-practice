#!/bin/bash
set -e

buildkite-agent artifact download hello/hello .
chmod +x hello/hello
USER_NAME=$(buildkite-agent meta-data get username)
echo "Name is: $USER_NAME"
./hello/hello "$USER_NAME"