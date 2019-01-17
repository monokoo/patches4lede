#!/bin/sh
cd /home/lede/lede-source
git checkout -- package/network/services/odhcpd/files/odhcpd-update
git checkout -- package/network/services/hostapd/files/hostapd.sh
git checkout -- package/network/ipv6/6in4/files/6in4.sh
git checkout -- package/base-files/files/etc/rc.button/reset
git checkout -- package/network/config/firewall/files/firewall.init
git checkout -- package/system/procd/files/procd.sh
git checkout -- package/kernel/mac80211/patches/
git checkout -- target/linux/x86/64/config-4.14

rm -f package/kernel/mac80211/patches/974-ath10k_add-LED-and-GPIO-controlling-support-for-various-chipsets-kcompat.patch


#clean aria2
cd feeds/packages/
git checkout -- net/aria2/files/aria2.conf
git checkout -- net/aria2/files/aria2.init
git checkout -- net/nlbwmon/files/nlbwmon.init
#git checkout -- net/usbip/patches-2.0/100-musl-compat.patch
git checkout -- net/haproxy/Makefile
git checkout -- net/uwsgi-cgi/files-luci-support/uwsgi.conf
git checkout -- net/samba4/files/samba.init
git checkout -- net/wifischedule/net/usr/bin/wifi_schedule.sh
git checkout -- net/miniupnpd/files/miniupnpd.init
git checkout -- net/mwan3/files/etc/config/mwan3
git checkout -- net/mwan3/files/lib/mwan3/mwan3.sh

cd ../luci/
#git checkout -- modules/luci-mod-system/luasrc/view/admin_system/flashops.htm
git checkout -- modules/luci-mod-system/luasrc/controller/admin/system.lua
git checkout -- modules/luci-mod-network/luasrc/model/cbi/admin_network/wifi.lua
#git checkout -- modules/luci-mod-system/luasrc/view/admin_system/reboot.htm
git checkout -- modules/luci-mod-status/htdocs/luci-static/resources/view/status/index.js  ##just_for_x64
git checkout -- modules/luci-mod-system/luasrc/view/admin_system/upgrade.htm
git checkout -- modules/luci-mod-system/luasrc/model/cbi/admin_system/fstab.lua
#git checkout -- modules/luci-mod-system/luasrc/view/admin_system/applyreboot.htm

git checkout -- modules/luci-base/luasrc/view/sysauth.htm
#git checkout -- modules/luci-base/luasrc/model/network.lua
git checkout -- modules/luci-base/luasrc/controller/admin/index.lua
git checkout -- modules/luci-base/luasrc/view/cbi/apply_widget.htm
git checkout -- modules/luci-mod-status/luasrc/view/admin_status/connections.htm
git checkout -- modules/luci-base/luasrc/view/cbi/wireless_modefreq.htm
git checkout -- modules/luci-base/luasrc/sys.lua
git checkout -- modules/luci-base/po/zh-cn/base.po
git checkout -- modules/luci-base/root/etc/config/luci
git checkout -- protocols/luci-proto-ppp/luasrc/model/cbi/admin_network/proto_pppoe.lua
git checkout -- applications/luci-app-wol/luasrc/model/cbi/wol.lua
git checkout -- applications/luci-app-minidlna/Makefile
git checkout -- applications/luci-app-ntpc/luasrc/model/cbi/ntpc/ntpc.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/controller/nlbw.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/model/cbi/nlbw/config.lua
git checkout -- applications/luci-app-nlbwmon/luasrc/view/nlbw/backup.htm
git checkout -- applications/luci-app-nlbwmon/luasrc/view/nlbw/display.htm
git checkout -- applications/luci-app-nlbwmon/htdocs/luci-static/resources/view/nlbw.js
git checkout -- applications/luci-app-wifischedule/luasrc/model/cbi/wifischedule/wifi_schedule.lua
git checkout -- applications/luci-app-samba4/luasrc/model/cbi/samba4.lua
git checkout -- applications/luci-app-upnp/po/zh-cn/upnp.po
git checkout -- applications/luci-app-upnp/luasrc/model/cbi/upnp/upnp.lua
git checkout -- applications/luci-app-mwan3/luasrc/controller/mwan3.lua
git checkout -- applications/luci-app-mwan3/luasrc/model/cbi/mwan/interface.lua
git checkout -- applications/luci-app-mwan3/luasrc/model/cbi/mwan/policy.lua
git checkout -- applications/luci-app-mwan3/luasrc/model/cbi/mwan/rule.lua
git checkout -- applications/luci-app-mwan3/luasrc/model/cbi/mwan/ruleconfig.lua
git checkout -- applications/luci-app-mwan3/luasrc/view/admin_status/index/mwan.htm
git checkout -- applications/luci-app-mwan3/luasrc/view/mwan/overview_status_interface.htm
git checkout -- applications/luci-app-mwan3/luasrc/view/mwan/status_detail.htm
git checkout -- applications/luci-app-mwan3/luasrc/view/mwan/status_diagnostics.htm
git checkout -- applications/luci-app-mwan3/luasrc/view/mwan/status_interface.htm
git checkout -- applications/luci-app-mwan3/luasrc/view/mwan/status_troubleshooting.htm
git checkout -- applications/luci-app-mwan3/po/zh-cn/mwan3.po
git checkout -- applications/luci-app-nft-qos/luasrc/controller/nft-qos.lua


echo "Everything has been cleaned!"
