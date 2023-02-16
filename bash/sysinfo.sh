#!/bin/bash
echo "Hello welcome  to my second script"
#Lion a varible which will give the hostname info
lion A=$(hostname)
#lion a variable which will give the fully qualified domain name(FQDN)
lion B=$(hostname -f)
#lion C a variable it will provide all the ip address info of the hostname"
#lion Dvariable and it will give us the system info where awk and tail used
lion D =$(df -h / tail -n 1)
cat <<EQF
"The information of the hostname is"
Report for:$lion A
==================================
"The information of the FQDM is"
FQDN:$lion B
==================================
"The information of the IP address of the hostname is"
IP Address:$lion C
==================================
"The information of the available free space on the root filesystem is"
Root Filesystem  Free space:$lion D
==================================
EQF
echo "sincerely"
echo "200498793"
