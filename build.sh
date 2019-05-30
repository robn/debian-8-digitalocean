#!/bin/bash
set -ex

# destroy existing virtualbox VM
VBoxManage controlvm debian poweroff || true
sleep 1
VBoxManage unregistervm debian --delete || true
rm -rf output-virtualbox-iso || true

# build them both
PACKER_LOG=1 PACKER_LOG_PATH=packer.log time packer build -on-error=abort -parallel=false -only virtualbox-iso jessie.json

