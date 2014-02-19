#!/bin/bash
DNSLBL_LIST=dnsbl.txt
host=$1
ip=`host $host | grep "has address" | head -n 1 | awk '{print $4}'`
if [[ -z "$ip" ]]
then
	echo "Could not get valid ip address for $host"
	exit 0;
fi

rev_ip=`echo $ip | sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/\4.\3.\2.\1/'`

for dnsbl in `cat $DNSLBL_LIST`
do
	if host -W 1 -t a $rev_ip.$dnsbl >/dev/null 2>&1
	then
		echo $host blacklisted on $dnsbl
	fi
done



