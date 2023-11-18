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
echo "! Blacklist for AdGuard Home powered by Tobias 'dontobi' S." >> header.tmp
echo "!" >> header.tmp
echo "! GitHub: https://github.com/dontobi" >> header.tmp
echo "! Repository: https://github.com/dontobi/AdGuardHome-Lists" >> header.tmp
echo "! Sources: AdGuard, hagezi and elliotwutingfeng" >> header.tmp
echo "" >> header.tmp
echo "! RegEx - Regular" >> header.tmp
echo "/^(.+[_.-])?adse?rv(er?|ice)?s?[0-9]*[_.-]/" >> header.tmp
echo "/^(.+[_.-])?telemetry[_.-]/" >> header.tmp
echo "/^(page|m)?ad[sx]?[0-9]*\./" >> header.tmp
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
echo "/^telemetry[0-9]*\./" >> header.tmp
echo "/^track(srv|er|ing)?[0-9]*\./" >> header.tmp
echo "/^trc?k[0-9]*\./" >> header.tmp
echo "/^wpad\./" >> header.tmp
echo "" >> header.tmp
echo "! RegEx - Block LAN Access" >> header.tmp
echo "/^\w+://10\.(?:(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))\.){2}(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))[:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "/^\w+://172\.(?:1[6-9]|2\d|3[01])(?:\.(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))){2}[:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "/^\w+://192\.168(?:\.(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))){2}[:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "/^\w+://\[f(?:[cd][0-9a-f]|e[89a-f])[0-9a-f]:[0-9a-f:]+\][:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "/^\w+://169\.254\.(?:[1-9]\d?|1\d{2}|2(?:[0-4]\d|5[0-4]))\.(?:[1-9]?\d|1\d{2}|2(?:[0-4]\d|5[0-5]))[:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "/^\w+://127\.(?:(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))\.){2}(?:[1-9]?\d|1\d\d|2(?:[0-4]\d|5[0-5]))[:/]/$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "" >> header.tmp
echo "! Domains - Block LAN Access" >> header.tmp
echo "||[::1]^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||localhost^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||0.0.0.0^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||[::]^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||local^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||home.arpa^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||airbox.home^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||airport^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||arcor.easybox^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||aterm.me^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||bthub.home^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||bthomehub.home^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||congstar.box^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||connect.box^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||easy.box^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||etxr^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||fritz.box^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||fritz.nas^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||fritz.repeater^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||giga.cube^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||hi.link^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||hitronhub.home^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||homerouter.cpe^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||huaweimobilewifi.com^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||myfritz.box^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||ntt.setup^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||pi.hole^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||plex.direct^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local|~app.plex.tv" >> header.tmp
echo "||repeater.asus.com^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||router.asus.com^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||routerlogin.com^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||routerlogin.net^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||samsung.router^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||speedport.ip^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||tplinkwifi.net^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||web.setup^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "||web.setup.home^$3p,domain=~localhost|~127.0.0.1|~[::1]|~0.0.0.0|~[::]|~local" >> header.tmp
echo "" >> header.tmp
echo "! Domains - Regular" >> header.tmp

# Final steps
cat header.tmp bl_build.tmp > blacklist.txt
rm *.tmp
