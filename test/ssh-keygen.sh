#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)
gen_dir=$(mktemp -d)

ssh-keygen -t rsa -N "" -f "$gen_dir/id_rsa"

kubectl create secret generic ssh-key \
  --from-file="$gen_dir/id_rsa" \
  --from-file="$gen_dir/id_rsa.pub"
