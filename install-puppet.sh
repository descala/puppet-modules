#!/bin/bash
# install puppet on wheezy from jessie

# this will remove any previous src (i.e CD-ROM)
cat << EOF > /etc/apt/sources.list
deb http://http.debian.net/debian/ wheezy main contrib non-free
deb-src http://http.debian.net/debian/ wheezy main contrib non-free
EOF

if [ ! -e /etc/apt/sources.list.d/jessie.list ]; then
  cat << EOF > /etc/apt/sources.list.d/jessie.list
deb http://http.debian.net/debian/ jessie main contrib non-free
deb-src http://http.debian.net/debian/ jessie main contrib non-free
EOF
fi

if [ ! -e /etc/apt/sources.list.d/puppetlabs.list ]; then
  cat << EOF > /etc/apt/sources.list.d/puppetlabs.list
deb http://apt.puppetlabs.com wheezy main dependencies
EOF
fi

if [ ! -e /etc/apt/preferences.d/1_stable.pref ]; then
  cat << EOF > /etc/apt/preferences.d/1_stable.pref 
Package: *
Pin: release n=wheezy
Pin-Priority: 900
EOF
fi

apt-get update
apt-get install puppet

# disable puppet runs
# we will always "puppet apply"
puppet agent --disable

apt-get install git-core

cd ~ && mkdir git && cd git
git clone https://github.com/descala/puppet-modules.git
git clone https://github.com/descala/puppet-desktop.git
cd puppet-modules
git submodule init &&  git submodule update

puppet apply ~/git/puppet-desktop/manifests/site.pp \
    --modulepath ~/git/puppet-modules:~/git/puppet-desktop/services
