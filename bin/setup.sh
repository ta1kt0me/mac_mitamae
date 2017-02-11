#!/bin/bash

set -x

cd $(dirname $0)/..
setup/mitamae-x86_64-darwin local -y setup/node.yml setup/init.rb
