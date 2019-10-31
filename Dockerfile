FROM alpine:3.4

RUN apk add --no-cache openssh git curl bash gnupg

RUN ssh-keygen -A

WORKDIR /git-server/

RUN mkdir /git-server/keys \
  && adduser -D -s /usr/bin/git-shell git \
  && mkdir /home/git/.ssh \
  && mkdir /home/git/git-shell-commands \
  && apk --update add tar

ARG password
RUN sh -c "echo git:${password:-ratherchangeme} |chpasswd"

COPY sshd_config /etc/ssh/sshd_config
COPY start.sh start.sh

EXPOSE 22

CMD ["sh", "start.sh"]
