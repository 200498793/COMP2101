#!/bin/bash
echo "Hello welcome  to my second script"
#dat1 a varible which will give the hostname info
dat1=$(hostname)
#dat2 a variable which will give the fully qualified domain name(FQDN)
dat2=$(hostname -f)
#dat3 a variable it will provide all the ip address info of the hostname"
dat3=$(hostname -I)
#dat4 a variable and it will give us the system info where awk and tail used
dat4=$(df -h / | awk '{print $4}' | tail -n 1)
cat <<EQF
"The information of the hostname is"
Report for:$dat1
==================================
"The information of the FQDM is"
FQDN:$dat2
==================================
"The information of the IP address of the hostname is"
IP Address:$dat3
==================================
"The information of the available free space on the root filesystem is"
Root Filesystem  Free space:$dat4
==================================
EQF
echo "sincerely"
echo "200498793"
