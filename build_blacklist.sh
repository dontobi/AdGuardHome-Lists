#!/bin/bash

# Download blacklists
wget -q -O raw_dontobi.tmp https://raw.githubusercontent.com/dontobi/AdGuardHome-Lists/main/blacklist.txt
wget -q -O raw_hagezi_1.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt
wget -q -O raw_hagezi_2.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt
wget -q -O raw_hagezi_3.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/hoster.txt
wget -q -O raw_hagezi_4.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/spam-tlds.txt
wget -q -O raw_hagezi_5.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.txt
wget -q -O raw_elliotwutingfeng.tmp https://raw.githubusercontent.com/elliotwutingfeng/Inversion-DNSBL-Blocklists/main/Google_hostnames_light_ABP.txt

# Prepair blacklists
sed -e "/^||/!d" raw_dontobi.tmp > bl_dontobi.tmp
sed -e "/^||/!d" raw_hagezi_1.tmp > bl_hagezi_1.tmp
sed -e "/^||/!d" raw_hagezi_2.tmp > bl_hagezi_2.tmp
sed -e "/^||/!d" raw_hagezi_3.tmp > bl_hagezi_3.tmp
sed -e "/^||/!d" raw_hagezi_4.tmp > bl_hagezi_4.tmp
sed -e "/^||/!d" raw_hagezi_5.tmp > bl_hagezi_5.tmp
sed -e "/^||/!d" -e 's/$all/^/' raw_elliotwutingfeng.tmp > bl_elliotwutingfeng.tmp

# combine lists
cat bl_*.tmp > bl_all.tmp
sort bl_all.tmp | uniq > bl_build.tmp

# Header
echo "! Blacklist for AdGuard Home powered by Tobias 'dontobi' S." >> bl_header.tmp
echo "!" >> bl_header.tmp
echo "! GitHub: https://github.com/dontobi" >> bl_header.tmp
echo "! Repository: https://github.com/dontobi/AdGuardHome-Lists" >> bl_header.tmp
echo "! Sources: AdGuard, hagezi and elliotwutingfeng" >> bl_header.tmp
echo "" >> header.tmp

# Final steps
cat bl_header.tmp bl_build.tmp > blacklist.txt
rm *.tmp
