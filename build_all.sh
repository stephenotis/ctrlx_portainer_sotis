#!/bin/bash
TARGET_ARCH=$(dpkg --print-architecture)
if [[ -n $1 ]]; then
   TARGET_ARCH=$1
fi
set -e
echo TARGET_ARCH: ${TARGET_ARCH}
echo --- clean snap
sudo snapcraft clean

echo --- build snap with architecture ${TARGET_ARCH}
sudo snapcraft pack --build-for=${TARGET_ARCH} --verbosity=verbose

echo --- clean snap
sudo snapcraft clean 
