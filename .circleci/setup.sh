#!/bin/bash -xe

ruby --version
bundle --version
gem --version

bundle check || bundle install --path=${BUNDLE_PATH:-vendor/bundle}
bundle update
bundle clean
