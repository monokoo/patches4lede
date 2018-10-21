#!/bin/sh
sh /home/lede/patches4lede/clean_patch.sh
cd /home/lede/lede-source
patch -p1 -i /home/lede/patches4lede/personal-modify.patch
[ -n "$(cat /home/lede/lede-source/.config | grep phicomm-k3)" ] && {
	echo "apply patches for K3..."
	patch -p1 -i /home/lede/patches4lede/just_for_k3.patch
	#patch -p1 -i /home/lede/patches4lede/mac80211-patches-k3.patch
}

if [ -n "$(cat /home/lede/lede-source/.config | grep x86_64)" ]; then
	echo "apply patches for x86_64..."
	patch -p1 -i /home/lede/patches4lede/just_for_x64.patch
	#patch -p1 -i /home/lede/patches4lede/mac80211-patches-k3.patch
else
	echo "apply patches for other archs..."
	patch -p1 -i /home/lede/patches4lede/just_for_other_arch.patch

fi


[ -n "$(cat /home/lede/lede-source/.config | grep CONFIG_PACKAGE_minidlna=y)" ] && {
	echo "disselect PACKAGE minidlna..."
	sed -i 's/CONFIG_PACKAGE_minidlna=y/# CONFIG_PACKAGE_minidlna is not set/' /home/lede/lede-source/.config
}

