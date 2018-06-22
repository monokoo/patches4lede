#!/bin/sh
sh /home/lede/patches4lede/clean_patch.sh
cd /home/lede/lede-source
patch -p1 -i /home/lede/patches4lede/personal-modify.patch
[ -n "$(cat /home/lede/lede-source/.config | grep phicomm-k3)" ] && {
	echo "apply patches for K3..."
	patch -p1 -i /home/lede/patches4lede/just_for_k3.patch
}

