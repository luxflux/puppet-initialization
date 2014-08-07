#!/bin/sh

set -e

password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

echo "Please give me your public ssh key: "
read ssh_key
echo ""

set -x
useradd -m -g admin -s /bin/bash admin
echo "admin:${password}" | sudo chpasswd ;

mkdir -p -m 700 ~admin/.ssh
echo ${ssh_key} > ~admin/.ssh/authorized_keys
chown -R admin. ~admin/.ssh
chmod 600 ~admin/.ssh/authorized_keys
