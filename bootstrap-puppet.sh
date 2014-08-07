#!/bin/sh

set -e

authorized_keys_url='https://raw.githubusercontent.com/luxflux/puppet-initialization/master/authorized_keys'
password=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;)

set -x
useradd -m -g admin -s /bin/bash admin
echo "admin:${password}" | sudo chpasswd ;

mkdir -p -m 700 ~admin/.ssh
wget -O ~admin/.ssh/authorized_keys ${authorized_keys_url}
chown -R admin. ~admin/.ssh
chmod 600 ~admin/.ssh/authorized_keys
