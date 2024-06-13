#!/bin/sh

rm -rf udata
cp -rf ./update udata

echo "1" > udata/dnake/bin/logo

zip udata.zip udata -r
./gen_upgrade --partion zip --version 1.0.0 --sys 10 --limit 0 --file udata.zip --save user_v907_$(date +%Y_%m_%d).img

rm -f udata.zip
rm -rf udata
