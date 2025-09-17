#!/bin/bash
TARGET_ARCH=$(dpkg --print-architecture)
if [[ -n $1 ]]; then
   TARGET_ARCH=$1
fi
echo TARGET_ARCH: ${TARGET_ARCH}

echo --- build content
bash build_content.sh ${TARGET_ARCH}

echo --- build snap
bash build_snap.sh ${TARGET_ARCH}
