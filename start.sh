#!/bin/sh

# If there is some public key in keys folder
# then it copies its contain in authorized_keys file
if [ "$(ls -A /git-server/keys/)" ]; then
  cd /home/git
  cat /git-server/keys/*.pub > .ssh/authorized_keys
  chown -R git:git .ssh
  chmod 700 .ssh
  chmod -R 600 .ssh/*
fi

# Set permissions
if [ "$(ls -A /git-server/repos/)" ]; then
  cd /git-server/repos
  chown -R git:git .
  chmod -R ug+rwX .
  find . -type d -exec chmod g+s '{}' +
fi

# Set seeder user name
git config --global user.email "root@gitsrv.git"
git config --global user.name "root"

# Init repo and seed from a tar.gz link
REPO_DIR=/git-server/repos/${REPO}
if [ ! -d "REPO_DIR" ]; then
  mkdir ${REPO_DIR}
  cd /git-server/repos
  curl -sL ${TAR_URL} | tar xz -C ./${REPO} --strip-components=1
  cd ${REPO_DIR}
  git init --shared=true
  git add .
  git commit -m "init"
  git checkout -b dummy
  cd /git-server/repos
  chown -R git:git .
  chmod -R ug+rwX .
  find . -type d -exec chmod g+s '{}' +
fi
ln -s ${REPO_DIR} /home/git/

# -D flag avoids executing sshd as a daemon
/usr/sbin/sshd -D
