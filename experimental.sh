#!/bin/bash

# Download blacklists
wget -q -O black_1.tmp https://abp.oisd.nl/
wget -q -O black_2.tmp https://abp.oisd.nl/nsfw/
wget -q -O black_3.tmp https://block.energized.pro/unified/formats/filter
wget -q -O black_4.tmp https://block.energized.pro/extensions/xtreme/formats/filter
wget -q -O black_5.tmp https://block.energized.pro/extensions/porn-lite/formats/filter
wget -q -O black_6.tmp https://block.energized.pro/extensions/regional/formats/filter
wget -q -O black_7.tmp https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts
#wget -q -O black_8.tmp https://ewpratten.github.io/youtube_ad_blocklist/adblockplus.txt

# Prepair blacklist 1 and 2
sed -e "/^!/d" -e "/^$/d" black_1.tmp > black_1.txt
sed -e "/^!/d" -e "/^$/d" black_2.tmp > black_2.txt

# Prepair blacklist 3 to 6
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" black_3.tmp > black_3.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" black_4.tmp > black_4.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" black_5.tmp > black_5.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" black_6.tmp > black_6.txt

# Prepair blacklist 7
sed -e "1,39d" -e "/^#/d" -e "/^$/d" -e "/#/d" -e "s/\0.0.0.0 /||/" -e "s/$/^/" black_7.tmp > black_7.txt

# Prepair blacklist 8
#sed -e "/^!/d" -e "/^[/d" -e "/^$/d" black_8.tmp > black_8.txt

# combine blacklists
cat black_*.txt | sort | uniq > black_experimental.txt

# Write Header
echo "# Experimental Blacklist for AdGuard Home powered by Tobias 'dontobi' S." >> header.txt
echo "#" >> header.txt
echo "# GitHub: https://github.com/dontobi" >> header.txt
echo "# Repository: https://github.com/dontobi/AdGuardHome-Lists" >> header.txt
echo "# Sources: oisd.nl, EnergizedProtection and StevenBlack" >> header.txt
echo "#" >> header.txt

# Final steps
cat header.txt black_experimental.txt > experimental.txt
rm black_*.txt black_*.tmp header.txt
