#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

kubectl get all || true
kubectl describe deployment gitsrv || true
kubectl logs deployment/gitsrv || true

