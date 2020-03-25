#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)
gen_dir=$(mktemp -d)

ssh-keygen -t rsa -N "" -f id_rsa

kubectl create secret generic ssh-key \
  --from-file=id_rsa \
  --from-file=id_rsa.pub
