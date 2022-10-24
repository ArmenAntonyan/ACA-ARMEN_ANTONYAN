#!/bin/bash
d="/root/report"
t="`date '+%m-%d-%Y-%H:%M'`"
ip="`ip address`"
l="`last | head -n 15`"
s="`df -h`"
m="`free -h`"
FILES_KEEP="10"
mkdir -p "${d}"
touch "${d}/report.${t}"

 echo "-----------ip info--------------" >> "${d}/report.${t}" 
 echo "${ip}" |grep -i inet >> "${d}/report.${t}" 
 echo -en '\n' >> "${d}/report.${t}" 
 echo "-----------UPTIME info--------------" >> "${d}/report.${t}" 
 echo "`w`" >> "${d}/report.${t}" 
 echo -en '\n' >> "${d}/report.${t}" 
 echo "-----------LAST LOGIN info--------------" >> "${d}/report.${t}"
 echo "${l}" >> "${d}/report.${t}" 
 echo -en '\n' >> "${d}/report.${t}" 
 echo "-----------Disk Space info--------------" >> "${d}/report.${t}"
 echo "${s}" >> "${d}/report.${t}" 
 echo -en '\n' >> "${d}/report.${t}" 
 echo "-----------free memory info--------------" >> "${d}/report.${t}"
 echo "${m}" >> "${d}/report.${t}" 

 ls -tp /root/report/* | grep -v '/$' | tail -n +$((FILES_KEEP+1)) | xargs -d '\n' -r rm --

