#!/usr/bin/env zsh

FORMULA=$1
GITHUB_USER=tamaracha
GITHUB_REPO=liblouis
BINTRAY_USER=tamaracha
BINTRAY_ROOT=https://dl.bintray.com/${BINTRAY_USER}/bottles-${GITHUB_REPO}

brew test-bot --root-url=${BINTRAY_ROOT} --bintray-org=${BINTRAY_USER} --tap=${GITHUB_USER}/${GITHUB_REPO} ${GITHUB_USER}/${GITHUB_REPO}/${FORMULA}
