#!/bin/bash
set -ex
export PATH=/sbin:/usr/sbin:$PATH

# need cloud-init 0.77, which is jessie-backports, but is a little bit awkward
# to get at in this post-jessie world
cat >/etc/apt/sources.list.d/backports.list <<EOF
deb http://archive.debian.org/debian jessie-backports main
EOF
cat >/etc/apt/apt.conf.d/backports.conf <<EOF
Acquire::Check-Valid-Until "false";
EOF

apt-get update

debconf-set-selections <<EOF
cloud-init  cloud-init/datasources  multiselect  ConfigDrive, None
EOF
DEBIAN_FRONTEND=noninteractive apt-get -t jessie-backports -y install cloud-init cloud-initramfs-growroot

apt-get clean

rm -f /etc/apt/sources.list.d/backports.list /etc/apt/apt.conf.d/backports.conf

apt-get update
