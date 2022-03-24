#!/bin/bash
DATE=$(date +%Y-%m-%d-%H%M%S)

# Delete old files
#rm *.txt *.tmp

# Download blocklists
wget -q -O block_1.tmp https://abp.oisd.nl/
wget -q -O block_2.tmp https://abp.oisd.nl/nsfw/
wget -q -O block_3.tmp https://block.energized.pro/unified/formats/filter
wget -q -O block_4.tmp https://block.energized.pro/extensions/xtreme/formats/filter
wget -q -O block_5.tmp https://block.energized.pro/extensions/porn-lite/formats/filter
wget -q -O block_6.tmp https://block.energized.pro/extensions/regional/formats/filter
wget -q -O block_7.tmp https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-gambling-porn/hosts

# Prepair blocklist 1 and 2
sed -e "/^!/d" -e "/^$/d" block_1.tmp > block_1.txt
sed -e "/^!/d" -e "/^$/d" block_2.tmp > block_2.txt

# Prepair blocklist 3 to 6
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" block_3.tmp > block_3.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" block_4.tmp > block_4.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" block_5.tmp > block_5.txt
sed -e "/\[/d" -e "/^#/d" -e "/^!/d" block_6.tmp > block_6.txt

# Prepair blocklist 7
sed -e "1,39d" -e "/^#/d" -e "/^$/d" -e "/#/d" -e "s/\0.0.0.0 /||/" -e "s/$/^/" block_7.tmp > block_7.txt

# combine blocklists
cat block_*.txt | sort | uniq > blocklist.txt

# Write Header
echo "# Combined Blocklist for AdGuard Home powered by Tobias 'dontobi' S." >> header.txt
echo "#" >> header.txt
echo "# GitHub: https://github.com/dontobi" >> header.txt
echo "# Repository: https://github.com/dontobi/AdGuardHome-Lists" >> header.txt
echo "# Sources: oisd.nl, EnergizedProtection and StevenBlack" >> header.txt
echo "#" >> header.txt
echo "# created on $DATE" >> header.txt
echo "#" >> header.txt

# Final steps
cat header.txt blocklist.txt > experimental.txt
rm block_*.txt block_*.tmp blocklist.txt header.txt