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
        echo "You need a filename"
    else
        git init --bare "/repos/$2.git/"
	rm -rf "/repos/$2.git/hooks"
	cp -R ./hooks "/repos/$2.git/"
	chown -hR git "/repos/$2.git"
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
    ls -1 /repos/
else
    echo "Invalid command. Options are create, delete and list."
fi
