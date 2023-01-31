#!/bin/sh

read -p 'Username: ' USER

adduser ${USER}

usermod -aG sudo ${USER}

cd /home/${USER}

mkdir .ssh

chmod 700 .ssh

chown ${USER}:${USER} .ssh

cat /home/pub_key >> .ssh/authorized_keys

chmod 600 .ssh/authorized_keys

chown ${USER}:${USER} .ssh/authorized_keys

su - ${USER} -c "umask 022 ; google-authenticator -t -f -d -w 3 -e 10 -r 3 -R 30"

cat /dev/null > /home/${USER}/.google_authenticator

cat /home/totp >> /home/${USER}/.google_authenticator

cat /dev/null > /home/pub_key

cat /dev/null > /home/totp

echo Created user ${USER} successfully
