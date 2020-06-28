FROM frolvlad/alpine-glibc

ARG USER
ARG USER_PASSWORD

RUN apk update && apk upgrade && apk add alpine-sdk musl util-linux wget cmake coreutils bash openssh tmux git curl nmap john nano gcc python3 jq gdb
RUN echo "@testing http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && apk add --update --no-cache radare2@testing --allow-untrusted
RUN adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D $USER
RUN echo "${USER} ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers \
  && mkdir /packages \
  && chown $USER:abuild /packages \
  && mkdir -p /var/cache/apk \
  && ln -s /var/cache/apk /etc/apk/cache
RUN apk add binwalk --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN echo "${USER}:${USER_PASSWORD}" | chpasswd

RUN rm -rf /etc/ssh/ssh_host_rsa_key /etc/ssh/ssh_host_dsa_key
RUN ssh-keygen -f /etc/ssh/ssh_host_rsa_key -N '' -t rsa
RUN ssh-keygen -f /etc/ssh/ssh_host_dsa_key -N '' -t dsa
RUN mkdir -p /var/run/sshd

ADD motd /etc/motd
EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
