#!/usr/bin/env bash
if [ -z "$1" ]
then
    /usr/sbin/sshd -De
elif [ "$1" = "masterkey" ]
then
    echo "Paste the key:" && cat > /home/git/.ssh/authorized_keys
    chmod 600 /home/git/.ssh/authorized_keys
    chown git /home/git/.ssh/authorized_keys
elif [ "$1" = "create" ]
then
    if [ -z "$2" ]
    then
        echo "You need a repo name"
    else
        git init --bare "/repos/$2.git/"
        rm -rf "/repos/$2.git/hooks"
        cp -R ./hooks "/repos/$2.git/"
        chown -hR git "/repos/$2.git"
        echo "git remote add origin ssh://git@$HOST/repos/$2.git"
    fi
elif [ "$1" = "delete" ]
then
    if [ -z "$2" ]
    then
        echo "You need a filename"
    else
        rm -rf "/repos/$2.git"
    fi
elif [ "$1" = "list" ]
then
    for path in $(find /repos/ -mindepth 1 -maxdepth 1)
    do
        echo "ssh://git@$HOST$path"
    done
else
    echo "Invalid command. Options are create, delete and list."
fi
