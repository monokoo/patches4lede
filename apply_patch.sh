#!/bin/sh
sh /home/lede/patches4lede/clean_patch.sh
cd /home/lede/lede-source
patch -p1 -i /home/lede/patches4lede/personal-modify.patch
[ -n "$(cat /home/lede/lede-source/.config | grep phicomm-k3)" ] && {
	echo "apply patches for K3..."
	patch -p1 -i /home/lede/patches4lede/just_for_k3.patch
	patch -p1 -i /home/lede/patches4lede/mac80211-patches-k3.patch
}

[ -n "$(cat /home/lede/lede-source/.config | grep CONFIG_PACKAGE_minidlna=y)" ] && {
	echo "disselect PACKAGE minidlna..."
	sed -i 's/CONFIG_PACKAGE_minidlna=y/# CONFIG_PACKAGE_minidlna is not set/' /home/lede/lede-source/.config
}

