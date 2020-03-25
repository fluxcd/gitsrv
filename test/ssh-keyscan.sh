#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

kubectl exec deployment/gitsrv ssh-keyscan gitsrv > known_hosts.txt
grep -E ssh-rsa known_hosts.txt
