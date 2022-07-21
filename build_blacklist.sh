#!/bin/bash

# Download blacklists
wget -q -O raw_dontobi.tmp https://raw.githubusercontent.com/dontobi/AdGuardHome-Lists/main/blacklist.txt
wget -q -O raw_oisd_1.tmp https://raw.githubusercontent.com/ookangzheng/dbl-oisd-nl/master/abp.txt
wget -q -O raw_oisd_2.tmp https://raw.githubusercontent.com/ookangzheng/dbl-oisd-nl/master/abp_nsfw.txt
wget -q -O raw_oisd_3.tmp https://raw.githubusercontent.com/ookangzheng/dbl-oisd-nl/master/abp_extra.txt
wget -q -O raw_adguard_1.tmp https://adguardteam.github.io/AdGuardSDNSFilter/Filters/filter.txt
wget -q -O raw_adguard_2.tmp https://raw.githubusercontent.com/AdguardTeam/FiltersRegistry/master/filters/filter_15_DnsFilter/filter.txt
wget -q -O raw_hagezi_1.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/multi.txt
wget -q -O raw_hagezi_2.tmp https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.txt
wget -q -O raw_stevenblack.tmp https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts

# Prepair blacklists
sed -e "/^||/!d" raw_dontobi.tmp > bl_dontobi.tmp
sed -e "/^||/!d" raw_oisd_1.tmp > bl_oisd_1.tmp
sed -e "/^||/!d" raw_oisd_2.tmp > bl_oisd_2.tmp
sed -e "/^||/!d" raw_oisd_3.tmp > bl_oisd_3.tmp
sed -e "/^||/!d" raw_adguard_1.tmp > bl_adguard_1.tmp
sed -e "/^||/!d" raw_adguard_2.tmp > bl_adguard_2.tmp
sed -e "/^||/!d" raw_hagezi_1.tmp > bl_hagezi_1.tmp
sed -e "/^||/!d" raw_hagezi_2.tmp > bl_hagezi_2.tmp
sed -e "/^0.0.0.0/!d" -e "s/\0.0.0.0 /||/" -e "/^||0.0.0.0/d" -e 's/$/^/' raw_stevenblack.tmp > bl_stevenblack.tmp

# combine lists
cat bl_*.tmp > bl_all.tmp
sort bl_all.tmp | uniq > bl_build.tmp

# Header
echo "! Blacklist for AdGuard Home powered by Tobias 'dontobi' S." >> header.tmp
echo "!" >> header.tmp
echo "! GitHub: https://github.com/dontobi" >> header.tmp
echo "! Repository: https://github.com/dontobi/AdGuardHome-Lists" >> header.tmp
echo "! Sources: AdGuard, oisd.nl, hagezi and StevenBlack" >> header.tmp
echo "" >> header.tmp
echo "! Blacklist - RegEx" >> header.tmp
echo "/^(.+[_.-])?adse?rv(er?|ice)?s?[0-9]*[_.-]/" >> header.tmp
echo "/^(.+[_.-])?telemetry[_.-]/" >> header.tmp
echo "/^(page|m)?ad[sx]?[0-9]*\./" >> header.tmp
echo "/^ad([sxv]?[0-9]*|system)[_.-]([^.[:space:]]+\.){1,}|[_.-]ad([sxv]?[0-9]*|system)[_.-]/" >> header.tmp
echo "/^adim(age|g)s?[0-9]*\./" >> header.tmp
echo "/^adservers?[0-9]*\./" >> header.tmp
echo "/^adtrack(er|ing)?[0-9]*\./" >> header.tmp
echo "/^advert(s|ising|ise(rs?))?[0-9]*\./" >> header.tmp
echo "/^affiliates?[0-9]*\./" >> header.tmp
echo "/^analytics?[_.-]/" >> header.tmp
echo "/^banners?[_.-]/" >> header.tmp
echo "/^beacons?[0-9]*\./" >> header.tmp
echo "/^count(ers?)?[0-9]*[_.-]/" >> header.tmp
echo "/^mads\./" >> header.tmp
echo "/^pixels?[0-9]*\./" >> header.tmp
echo "/^s?analytics?[0-9]*\./" >> header.tmp
echo "/^s?metrics?[0-9]*\./" >> header.tmp
echo "/^stat(s|istics)?[0-9]*[_.-]/" >> header.tmp
echo "/^telemetry[0-9]*\./" >> header.tmp
echo "/^track(srv|er|ing)?[0-9]*\./" >> header.tmp
echo "/^trc?k[0-9]*\./" >> header.tmp
echo "/^wpad\./" >> header.tmp
echo "/(\.asia$|\.cn$|\.hk$|\.jp$|\.kp$|\.kr$|\.ru$\.su$|\.vn$)/" >> header.tmp
echo "/(\.adult$|\.cam$|\.gay$|\.porn$|\.sex$|\.sexy$|\.tube$|\.webcam$|\.xxx$)/" >> header.tmp
echo "/(\.bet$|\.bar$|\.casino$|\.date$|\.gq$|\.icu$|\.ml$|\.poker$|\.surf$|\.top$)/" >> header.tmp
echo "" >> header.tmp
echo "! Blacklist - Regular" >> header.tmp

# Final steps
cat header.tmp bl_build.tmp > blacklist.txt
rm *.tmp
