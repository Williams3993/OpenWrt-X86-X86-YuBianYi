#!/bin/bash
#=================================================
# Description: DIY script for OpenWrt compilation
# License: MIT
# Author: trainSu (Modified by Assistant)
#=================================================

# Step 1: 修改默认 IP 地址
# 将默认的 192.168.1.1 修改为 192.168.89.1
sed -i 's/192.168.1.1/192.168.89.1/g' package/base-files/files/bin/config_generate

# Step 2: 修改主机名
# 将默认的主机名 "OpenWrt" 修改为 "OpenWrt23-X86-X64"
# 主机名不能是纯数字，也不能使用中文字符
sed -i 's/OpenWrt/OpenWrt23-X86-X64/g' package/base-files/files/bin/config_generate

# Step 3: 修改默认时区
# 将默认时区从 "UTC" 修改为 "CST-8"
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate

# Step 4: 增加时区名称设置为 "Asia/Shanghai"
# 在时区设置后添加区域名称设置
sed -i "/set system.\@system\[-1\].timezone='CST-8'/a\ \ \ \ set system.\@system\[-1\].zonename='Asia/Shanghai'" package/base-files/files/bin/config_generate

# Step 5: 自定义网络配置
# 创建网络配置文件并写入自定义配置
mkdir -p package/base-files/files/etc/config  # 确保配置目录存在

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
    option ipaddr '192.168.89.1'  # 默认 IP 地址
    option netmask '255.255.255.0'

config interface 'wan'
    option device 'eth1'
    option proto 'dhcp'
EOF

# 提示：以上配置适用于 X86 平台。若编译其他平台，请根据需求调整接口配置。
