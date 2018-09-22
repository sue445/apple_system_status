#!/bin/bash -xe

ruby --version
bundle --version
gem --version

bundle check || bundle update
bundle clean
