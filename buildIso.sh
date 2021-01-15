#!/bin/bash
set -e

echo "Cleanup the archiso directory"
[ -d archiso/ ] && rm -rf archiso

mkdir archiso

echo "Copy archiso files from the system to the local archiso directory"
cp -R /usr/share/archiso/configs/releng/* archiso/

echo "Copy custom files in archiso"
cp -rf custom/* archiso/

echo "Change the owner to root"
chown -R root:root archiso

cd archiso

echo "Launch the build.sh script"
echo "Change the owner back to the current user"
sh build.sh && chown -R 1000:1000 ./*