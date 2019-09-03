#!/bin/bash
set -ex
export PATH=/sbin:/usr/sbin:$PATH

# must be the last script; the provisioning user doesn't exist anymore after this

# destroy the provisioning user
userdel -r -f packer || true

# shut us down
# some hoop jumping here because packer is not expecting this
sync
/etc/init.d/ssh stop
nohup shutdown -hP now < /dev/null > /dev/null 2>&1 &
exit 0
