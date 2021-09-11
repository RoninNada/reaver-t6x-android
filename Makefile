all: libs/$(TARGET_ARCH_ABI)/reaver

libs/$(TARGET_ARCH_ABI)/reaver: Android.mk ../libsqlite/local/$(TARGET_ARCH_ABI)/libsqlite.a ../libpcap/local/$(TARGET_ARCH_ABI)/libpcap.a
	$(NDK_ROOT)/ndk-build NDK_APPLICATION_MK=`pwd`/Application.mk NDK_APP_OUT=. TARGET_PLATFORM=android-21

../libsqlite/local/$(TARGET_ARCH_ABI)/libsqlite.a: FORCE
	cd ../libsqlite && make

../libpcap/local/$(TARGET_ARCH_ABI)/libpcap.a: FORCE
	cd ../libpcap && make

install: libs/armeabi/aircrack-ng
	adb push libs/armeabi/aireplay-ng /sdcard/
	adb shell 'su -c "mount -o rw,remount /system"'
	adb shell 'su -c "cp /sdcard/aireplay-ng /system/bin/aireplay-ng"'
	adb shell 'su -c "chmod +x /system/bin/aireplay-ng"'

FORCE:

clean:
	rm -Rf libs
	rm -Rf local