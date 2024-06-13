#!/bin/sh

ROOT=$1

#------------------------------------------------------------
mount -o remount,rw /dnake/bin

cp -f $ROOT/dnake/bin/* /dnake/bin/
chmod 0777 /dnake/bin/*

cp -f $ROOT/dnake/bin/prompt/* /dnake/bin/prompt/
chmod 0777 /dnake/bin/prompt/*

cp -rf $ROOT/dnake/httpd /dnake/bin/
chmod -R 0777 /dnake/bin/httpd/

#cp -f $ROOT/dnake/eth_wifi.xml /dnake/cfg/
#chmod -R 0777 /dnake/cfg/eth_wifi.xml

#cp -rf $ROOT/dnake/data/ui_ver /dnake/data/
#chmod -R 0777 /dnake/data/ui_ver
if [ -e /dnake/data/desktop_main.xml ]; then
	rm -f /dnake/bin/desktop_main.xml
else 	
	cp -f $ROOT/dnake/bin/desktop_main.xml /dnake/data/
	chmod 0777 /dnake/data/desktop_main.xml
fi

cp -f $ROOT/dnake/bin/desktop_apps.xml /dnake/data/
chmod 0777 /dnake/data/desktop_apps.xml

cp -rf $ROOT/dnake/bin/bg /dnake/data/
chmod -R 0777 /dnake/data/bg/

if [ -e /dnake/cfg/desktop_bg_path ]; then
	rm -f /dnake/bin/desktop_bg_path
else 	
	cp -f $ROOT/dnake/bin/desktop_bg_path /dnake/cfg/
	chmod 0777 /dnake/cfg/desktop_bg_path
fi

sync

#------------------------------------------------------------
mount -o remount,rw /product

cp -f $ROOT/product/app/*.apk /product/app/
chmod 0644 /product/app/*.apk

cp -f $ROOT/product/lib/* /product/lib/
chmod 0644 /product/lib/*
cp -f $ROOT/product/lib64/* /product/lib64/
chmod 0644 /product/lib64/*

cp -f $ROOT/product/build.prop /product/
chmod 0644 /product/build.prop

mount -o remount,rw /
cp -f $ROOT/product/app_sys/services.jar /system/framework/
chmod 0644 /system/framework/services.jar

cp -f $ROOT/product/media_sys/bootanimation.zip /system/media/
chmod 0644 /system/media/bootanimation.zip

cp -f $ROOT/product/sys_lib/libandroid_runtime.so /system/lib/
chmod 0644 /system/lib/libandroid_runtime.so
cp -f $ROOT/product/sys_lib64/libandroid_runtime.so /system/lib64/
chmod 0644 /system/lib64/libandroid_runtime.so

cp -f $ROOT/product/sys_xbin/su /system/xbin/
chmod 6755 /system/xbin/su
sync

mount -o remount,rw /storage/emulated/0/Download
cp -f $ROOT/product/app_sd/chrome.apk /storage/emulated/0/Download/
chmod 0644 /storage/emulated/0/Download/chrome.apk

#mount -o remount,rw /storage/emulated/0/Pictures
#cp -f $ROOT/product/bg_sd/bg_default.webp /storage/emulated/0/Pictures/
#chmod 0644 /storage/emulated/0/Pictures/bg_default.webp

#--flush nand--
sync
echo 3 > /proc/sys/vm/drop_caches
sync
echo flush 65535 > /sys/nand_driver0/nand_debug
sleep 2
sync
