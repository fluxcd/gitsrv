# gitsrv

[![build](https://github.com/fluxcd/gitsrv/workflows/build/badge.svg)](https://github.com/fluxcd/gitsrv/actions)
[![e2e](https://github.com/fluxcd/gitsrv/workflows/e2e/badge.svg)](https://github.com/fluxcd/gitsrv/actions)

SSH only Git Server used to host a git repository initialized from a tar.gz URL.

## Usage

Generate a SSH key:

```bash
gen_dir=$(mktemp -d)
ssh-keygen -t rsa -N "" -f "$gen_dir/id_rsa"

kubectl create secret generic ssh-key \
  --from-file="$gen_dir/id_rsa" \
  --from-file="$gen_dir/id_rsa.pub"
```

Deploy the git server:

```bash
kubectl apply -k github.com/gitsrv//deploy
```

Clone the repo from another pod that has the same `ssh-key` secret mounted:

```bash
git clone -b master ssh://git@gitsrv/~/cluster.git
```
