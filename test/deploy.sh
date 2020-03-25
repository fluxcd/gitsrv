#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

kubectl apply -f "$repo_root/test/fixtures/deployment.yaml"

kubectl rollout status deployment/gitsrv --timeout=1m
