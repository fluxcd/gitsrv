#!/usr/bin/env bash

repo_root=$(git rev-parse --show-toplevel)

docker build -t test/gitsrv:latest .

kind load docker-image test/gitsrv:latest

