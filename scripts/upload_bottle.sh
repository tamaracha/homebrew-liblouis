#!/usr/bin/env zsh

BINTRAY_USER=tamaracha
BINTRAY_ROOT=https://dl.bintray.com/${BINTRAY_USER}/bottles-liblouis
GIT_USER=$(git config --global --get user.name)
GIT_EMAIL=$(git config --global --get user.email)

brew test-bot --ci-upload --git-name=${GIT_USER} --git-email=${GIT_EMAIL} --bintray-org=${BINTRAY_USER} --root-url=${BINTRAY_ROOT}
