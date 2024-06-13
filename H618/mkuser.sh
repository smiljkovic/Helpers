#!/bin/sh

rm -rf udata
cp -rf romfs udata

zip udata.zip udata -r
./gen_upgrade --partion zip --version 1.0.0 --sys 3369 --limit 0 --file udata.zip --save user_v904_A10_$(date +%Y_%m_%d).img

rm -f udata.zip
rm -rf udata
