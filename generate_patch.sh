#!/bin/sh
date=$(date +%Y%m%d%H%M%S)
new_generate_patch=/home/lede/patches4lede/new_generate_patch_$date.patch
new_for_k3=/home/lede/patches4lede/new_for_k3_$date.patch
new_for_other_arch=/home/lede/patches4lede/new_for_other_arch_$date.patch
new_for_x64=/home/lede/patches4lede/new_for_x64_$date.patch
source_file=/tmp/files_source
source_package=/tmp/files_package
source_luci=/tmp/files_luci

echo "$date : now generate new patch..."

sh /home/lede/patches4lede/apply_patch.sh

get_new_patch(){
	for file in $(cat $1)
	do
		cp -f $file $file-new
		git checkout $file

		if [ "$file" = "modules/luci-base/luasrc/view/cbi/wireless_modefreq.htm" ]; then
			new_patch="$new_for_k3"
		elif [ "$file" = "modules/luci-mod-status/htdocs/luci-static/resources/view/status/index.js" ]; then
			if [ -n "$(cat /home/lede/lede-source/.config | grep x86_64)" ]; then
				new_patch="$new_for_x64"
			else
				new_patch="$new_for_other_arch"
			fi
		else
			new_patch="$new_generate_patch"
		fi

		diff -uN $file $file-new >> $new_patch
		if [ -n "$2" ]; then
			sed -i "s#--- $file#--- a/$2/$file#g" $new_patch
			sed -i "s#+++ $file-new#+++ b/$2/$file#g" $new_patch
		else
			sed -i "s#--- $file#--- a/$file#g" $new_patch
			sed -i "s#+++ $file-new#+++ b/$file#g" $new_patch
		fi
		rm -f $file-new
		rm -f $file.orig
		rm -f $file.rej
	done
}

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
target/linux/x86/64/config-default"

echo $files_source > $source_file
get_new_patch $source_file 

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
net/miniupnpd/files/miniupnpd.init
net/mwan3/files/etc/config/mwan3
net/mwan3/files/lib/mwan3/mwan3.sh
net/mwan3/files/usr/sbin/mwan3"

echo $files_packages > $source_package
get_new_patch $source_package  "feeds/packages"

cd ../luci/

files_luci="
modules/luci-mod-system/luasrc/controller/admin/system.lua
modules/luci-mod-network/luasrc/model/cbi/admin_network/wifi.lua
modules/luci-mod-status/htdocs/luci-static/resources/view/status/index.js
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
applications/luci-app-upnp/luasrc/model/cbi/upnp/upnp.lua
applications/luci-app-mwan3/luasrc/controller/mwan3.lua
applications/luci-app-mwan3/luasrc/model/cbi/mwan/interface.lua
applications/luci-app-mwan3/luasrc/model/cbi/mwan/policy.lua
applications/luci-app-mwan3/luasrc/model/cbi/mwan/rule.lua
applications/luci-app-mwan3/luasrc/model/cbi/mwan/ruleconfig.lua
applications/luci-app-mwan3/luasrc/view/admin_status/index/mwan.htm
applications/luci-app-mwan3/luasrc/view/mwan/overview_status_interface.htm
applications/luci-app-mwan3/luasrc/view/mwan/status_detail.htm
applications/luci-app-mwan3/luasrc/view/mwan/status_diagnostics.htm
applications/luci-app-mwan3/luasrc/view/mwan/status_interface.htm
applications/luci-app-mwan3/luasrc/view/mwan/status_troubleshooting.htm
applications/luci-app-mwan3/po/zh-cn/mwan3.po
applications/luci-app-nft-qos/luasrc/controller/nft-qos.lua"

echo $files_luci > $source_luci
get_new_patch $source_luci "feeds/luci"

[ ! -s "$new_for_k3" ] && rm -rf $new_for_k3

echo "New patch has been generated!"

