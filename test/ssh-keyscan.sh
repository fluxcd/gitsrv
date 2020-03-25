#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)
gen_dir=$(mktemp -d)

kubectl exec -it deployment/gitsrv ssh-keyscan gitsrv > known_hosts.txt
cat known_hosts.txt | grep gitsrv
