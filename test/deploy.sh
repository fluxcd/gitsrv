#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

kubectl apply -k "$repo_root/test/deploy"

kubectl rollout status deployment/gitsrv --timeout=1m
