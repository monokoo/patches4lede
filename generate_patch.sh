#!/bin/sh

date=$(date +%Y%m%d%H%M%S)
new_generate_patch=/home/lede/patches4lede/generate-patch-$date.patch

sh /home/lede/patches4lede/apply_patch.sh

get_new_patch(){}
	local files=$1
	for file in $files
	do
		cp $file $file-new
		diff -uN $file $file-new >> $new_generate_patch
		rm -f $file-new
		rm -f $file.org
	done
}
	
sh /home/lede/patches4lede/clean_patch.sh


#!/bin/sh
cd /home/lede/lede-source

files_source="
package/network/services/odhcpd/files/odhcpd-update 
package/network/services/hostapd/files/wps-hotplug.sh
package/network/services/hostapd/files/hostapd.sh
package/network/ipv6/6in4/files/6in4.sh
package/base-files/files/etc/rc.button/reset
package/network/config/firewall/files/firewall.init
package/system/procd/files/procd.sh
package/kernel/mac80211/patches/
target/linux/x86/64/config-default"

get_new_patch files_source

#clean aria2
cd feeds/packages/

files_packages="
net/aria2/files/aria2.conf
net/aria2/files/aria2.init
net/nlbwmon/files/nlbwmon.init
net/haproxy/Makefile
net/nginx/Makefile
net/nginx/files-luci-support/luci_nginx_ssl.conf
net/nginx/files-luci-support/luci_nginx.conf
net/uwsgi-cgi/files-luci-support/uwsgi.conf
net/samba4/files/samba.init
net/wifischedule/net/usr/bin/wifi_schedule.sh
net/miniupnpd/files/miniupnpd.init"

get_new_patch files_packages

cd ../luci/

files_luci="
modules/luci-mod-system/luasrc/controller/admin/system.lua
modules/luci-mod-network/luasrc/model/cbi/admin_network/wifi.lua
modules/luci-mod-status/luasrc/view/admin_status/index.htm
modules/luci-mod-system/luasrc/view/admin_system/upgrade.htm
modules/luci-mod-system/luasrc/model/cbi/admin_system/fstab.lua
modules/luci-base/luasrc/view/sysauth.htm
modules/luci-base/luasrc/controller/admin/index.lua
modules/luci-base/luasrc/view/cbi/apply_widget.htm
modules/luci-mod-status/luasrc/view/admin_status/connections.htm
modules/luci-base/luasrc/view/cbi/wireless_modefreq.htm
modules/luci-base/luasrc/sys.lua
modules/luci-base/po/zh-cn/base.po
modules/luci-base/root/etc/config/luci
protocols/luci-proto-ppp/luasrc/model/cbi/admin_network/proto_pppoe.lua
applications/luci-app-wol/luasrc/model/cbi/wol.lua
applications/luci-app-minidlna/Makefile
applications/luci-app-ntpc/luasrc/model/cbi/ntpc/ntpc.lua
applications/luci-app-nlbwmon/luasrc/controller/nlbw.lua
applications/luci-app-nlbwmon/luasrc/model/cbi/nlbw/config.lua
applications/luci-app-nlbwmon/luasrc/view/nlbw/backup.htm
applications/luci-app-nlbwmon/luasrc/view/nlbw/display.htm
applications/luci-app-wifischedule/luasrc/model/cbi/wifischedule/wifi_schedule.lua
applications/luci-app-samba4/luasrc/model/cbi/samba4.lua
applications/luci-app-upnp/po/zh-cn/upnp.po
applications/luci-app-upnp/luasrc/model/cbi/upnp/upnp.lua"

get_new_patch files_luci

echo "New patch has been generated!"

