# gitsrv

[![build](https://github.com/fluxcd/gitsrv/workflows/build/badge.svg)](https://github.com/fluxcd/gitsrv/actions)

SSH only Git Server used to host a git repository initialized from a tar.gz URL.

Kubernetes deployment example:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    name: gitsrv
  name: gitsrv
  namespace: ide
spec:
  replicas: 1
  selector:
    matchLabels:
      name: gitsrv
  template:
    metadata:
      labels:
        name: gitsrv
    spec:
      containers:
      - image: fluxcd/gitsrv:0.1.3
        name: git
        env:
        - name: REPO
          value: "podinfo.git"
        - name: TAR_URL
          value: "https://github.com/stefanprodan/podinfo/archive/3.1.0.tar.gz"
        ports:
        - containerPort: 22
          name: ssh
          protocol: TCP
        volumeMounts:
        - mountPath: /git-server/repos
          name: git-server-data
        - mountPath: /git-server/keys
          name: ssh-git
      volumes:
      - name: ssh-git
        secret:
          secretName: ssh-git
      - name: git-server-data
        emptyDir: {}
```

Clone the repo from another pod that has the same `ssh-git` secret mounted:

```bash
git clone -b master ssh://git@gitsrv/~/podinfo.git
```
