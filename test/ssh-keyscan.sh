#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

kubectl exec -it deployment/gitsrv ssh-keyscan gitsrv > known_hosts.txt
grep -E gitsrv known_hosts.txt
