#!/bin/sh

ROOT=$1

#------------------------------------------------------------
mount -o remount,rw /dnake/bin

cp -f $ROOT/dnake/bin/* /dnake/bin/
chmod 0777 /dnake/bin/*

cp -rf $ROOT/dnake/httpd /dnake/bin/
chmod -R 0777 /dnake/bin/httpd/

cp -f $ROOT/dnake/bin/prompt/* /dnake/bin/prompt/
chmod 0777 /dnake/bin/prompt/*

cp -f $ROOT/dnake/bin/ringtone/* /dnake/bin/ringtone/
chmod 0777 /dnake/bin/ringtone/*
sync
#------------------------------------------------------------
mount -o remount,rw /product

cp -f $ROOT/product/app/*.apk /product/app/
chmod 0644 /product/app/*.apk

cp -f $ROOT/product/lib/*.so /product/lib/
chmod 0644 /product/lib/*.so

cp -f $ROOT/product/lib64/*.so /product/lib64/
chmod 0644 /product/lib64/*.so

mount -o remount,rw /
cp -f $ROOT/product/media_800/bootanimation.zip /system/media/
chmod 0644 /system/media/bootanimation.zip
sync

#--flush flash--
echo 50 > /proc/sys/vm/dirty_writeback_centisecs
echo 50 > /proc/sys/vm/dirty_expire_centisecs
echo 4096 > /proc/sys/vm/dirty_bytes
echo 4096 > /proc/sys/vm/dirty_background_bytes
sync

#--write dummy data to flush--
dd if=/dev/urandom bs=1024 count=4096 of=/dnake/bin/dummy.dat
dd if=/dev/urandom bs=1024 count=4096 of=/product/dummy.dat
sync
sleep 4

rm -f /dnake/bin/dummy.dat
rm -f /product/dummy.dat
sync
