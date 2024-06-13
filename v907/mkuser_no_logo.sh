#!/bin/sh

rm -rf udata
cp -rf ./update_no_logo udata

echo "0" > udata/dnake/bin/logo

zip udata.zip udata -r
./gen_upgrade --partion zip --version 1.0.0 --sys 10 --limit 0 --file udata.zip --save user_v907_no_logo_$(date +%Y_%m_%d).img

rm -f udata.zip
rm -rf udata
