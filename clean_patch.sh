#!/bin/sh
cd /home/lede/lede-source
git checkout -- package/network/services/odhcpd/files/odhcpd-update
git checkout -- package/network/services/hostapd/files/wps-hotplug.sh
git checkout -- package/network/services/hostapd/files/hostapd.sh
git checkout -- package/network/ipv6/6in4/files/6in4.sh
git checkout -- package/base-files/files/etc/rc.button/reset

rm -f package/kernel/mac80211/patches/970-0001-ath10k_add-LED-and-GPIO-controlling-support-for-various-chipsets.patch
rm -f package/kernel/mac80211/patches/970-0002-ath10k_add-LED-and-GPIO-controlling-support-for-various-chipsets-kcompat.patch


#clean aria2
cd feeds/packages/
git checkout -- net/aria2/files/aria2.conf
git checkout -- net/nlbwmon/files/nlbwmon.init
git checkout -- net/usbip/patches-2.0/100-musl-compat.patch
git checkout -- net/haproxy/Makefile
git checkout -- net/uwsgi-cgi/files-luci-support/uwsgi.conf
git checkout -- net/nginx/files-luci-support/luci_nginx_ssl.conf

cd ../luci/
#git checkout -- modules/luci-mod-admin-full/luasrc/view/admin_system/flashops.htm
git checkout -- modules/luci-mod-admin-full/luasrc/controller/admin/system.lua
git checkout -- applications/luci-app-wol/luasrc/model/cbi/wol.lua
git checkout -- applications/luci-app-minidlna/Makefile
git checkout -- applications/luci-app-ntpc/luasrc/model/cbi/ntpc/ntpc.lua
git checkout -- modules/luci-base/luasrc/view/sysauth.htm
git checkout -- modules/luci-base/root/etc/config/luci
git checkout -- protocols/luci-proto-ppp/luasrc/model/cbi/admin_network/proto_pppoe.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/controller/nlbw.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/model/cbi/nlbw/config.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/view/nlbw/backup.htm
git checkout -- applications/luci-app-nlbwmon/luasrc/view/nlbw/display.htm
git checkout -- modules/luci-base/po/zh-cn/base.po


echo "Everything is done!"
cd /home/lede/lede-source
