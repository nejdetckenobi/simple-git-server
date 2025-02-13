FROM ubuntu

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

# The rest of it
ENV SSH_DIR=""
ENV REPOS_DIR=""
ENV HOST=""

WORKDIR /app


RUN mkdir /repos

RUN apt update
RUN apt upgrade -y

RUN mkdir -p /etc/ssh/sshd_config.d

RUN apt install -y git curl ssh openssh-server
RUN mkdir /var/run/sshd

COPY . .

RUN mv 0001-git-ssh-config /etc/ssh/sshd_config.d/0001-git-ssh-config
RUN adduser --disabled-password --gecos "" git
RUN chsh git -s $(which git-shell)

RUN git config --global --add safe.directory '*'
RUN git config --global init.defaultBranch master

EXPOSE 22

ENTRYPOINT ["/tini", "--", "sh", "docker-entrypoint.sh"]

