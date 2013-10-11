#!/bin/bash
# install puppet on wheezy from jessie

if [ ! -e /etc/apt/sources.list.d/jessie.list ]; then
  cat << EOF > /etc/apt/sources.list.d/jessie.list
deb http://http.debian.net/debian/ jessie main contrib non-free
deb-src http://http.debian.net/debian/ jessie main contrib non-free
EOF
fi

if [ ! -e /etc/apt/preferences.d/1_stable.pref ]; then
  cat << EOF > /etc/apt/preferences.d/1_stable.pref 
Package: *
Pin: release a=stable
Pin-Priority: 900
EOF
fi

if [ ! -e /etc/apt/preferences.d/10_puppet.pref ]; then
  cat << EOF > /etc/apt/preferences.d/10_puppet.pref 
Package: puppet*
Pin: release a=jessie
Pin-Priority: 990
EOF
fi

apt-get update
apt-get install puppet -t jessie

# disable puppet runs
# we will always "puppet apply"
puppet agent --disable
