#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: trainSu
#=================================================

# Modify default IP
sed -i 's/192.168.1.1/192.168.89.1/g' package/base-files/files/bin/config_generate

# 修改主机名字，把 iStore OS 修改你喜欢的就行（不能纯数字或者使用中文）
# sed -i 's/OpenWrt/iStore OS/g' package/base-files/files/bin/config_generate
sed -i 's/OpenWrt/OpenWrt23-X86-X64/g' package/base-files/files/bin/config_generate
# 修改默认时区为 CST-8
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate

# 增加设置时区名称为 Asia/Shanghai 的代码
sed -i "/set system.\@system\[-1\].timezone='CST-8'/a\ \ \ \ set system.\@system\[-1\].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

mkdir -p package/base-files/files/etc/config
cat << EOF > package/base-files/files/etc/config/network
config device
    option name 'br-lan'
    option type 'bridge'
    list ports 'eth0'
    list ports 'eth2'
    list ports 'eth3'

config interface 'lan'
    option device 'br-lan'
    option proto 'static'
    option ipaddr '192.168.89.1'  # 修改为默认 IP
    option netmask '255.255.255.0'

config interface 'wan'
    option device 'eth1'
    option proto 'dhcp'
EOF
