#!/usr/bin/env bash

set -e

local_port=""

coproc kubectl port-forward svc/gitsrv :22
read -r local_port <&"${COPROC[0]}"-
local_port=$(echo "$local_port" | sed 's%.*:\([0-9]*\).*%\1%')

ssh_cmd="ssh -o UserKnownHostsFile=/dev/null  -o StrictHostKeyChecking=no -i id_rsa -p $local_port"

GIT_SSH_COMMAND="${ssh_cmd}" git ls-remote ssh://git@localhost/git-server/repos/cluster.git master
