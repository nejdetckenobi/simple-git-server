FROM ubuntu

ENV PATH="${PATH}:/home/git/bin"
ENV AUTHORIZED_KEYS=""
ENV HOST=""

WORKDIR /app

RUN mkdir /repos

RUN apt update
RUN apt upgrade -y

RUN mkdir -p /etc/ssh/sshd_config.d
RUN echo "LogLevel DEBUG3" > /etc/ssh/sshd_config.d/0001-git-ssh-config

RUN apt install -y git curl ssh openssh-server
RUN mkdir /var/run/sshd

COPY . .

RUN adduser --disabled-password --gecos "" git
RUN chsh git -s $(which git-shell)

RUN mv scripts /home/git/bin
RUN chown -hR git /home/git/bin
RUN chmod +x /home/git/bin/masterkey
RUN git config --global --add safe.directory '*'
RUN git config --global init.defaultBranch master
RUN mkdir -p /home/git/.ssh && chmod 700 /home/git/.ssh
RUN chown -hR git /home/git/.ssh && chown git /home/git/.ssh/authorized_keys


EXPOSE 22

ENTRYPOINT ["sh", "docker-entrypoint.sh"]


