#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)
gen_dir=$(mktemp -d)

kubectl exec -it deployment/gitsrv ssh-keyscan gitsrv > "$gen_dir/known_hosts"
cat "$gen_dir/known_hosts" |  grep gitsrv
