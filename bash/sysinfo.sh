#!/bin/bash
echo "Hello welcome  to my second script"
#LION1 a varible which will give the hostname info
Lion1=$(hostname)
#Lion2 a variable which will give the fully qualified domain name(FQDN)
Lion2=$(hostname -f)
#Lion3 a variable it will provide all the ip address info of the hostname"
Lion3=$(hostname -I)
#Lion4 a variable and it will give us the system info where awk and tail used
Lion4=$(df -h / | awk '{print $4}' | tail -n 1)
cat <<EQF
"The information of the hostname is"
Report for:$Lion1
==================================
"The information of the FQDM is"
FQDN:$Lion2
==================================
"The information of the IP address of the hostname is"
IP Address:$Lion3
==================================
"The information of the available free space on the root filesystem is"
Root Filesystem  Free space:$Lion4
==================================
EQF

echo "Sincerely"
echo "200498793"
