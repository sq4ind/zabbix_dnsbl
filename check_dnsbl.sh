#!/bin/bash
DNSLBL_LIST=dnsbl.txt
host=$1
ip=`host $host | grep "has address" | head -n 1 | awk '{print $4}'`
if [[ -z "$ip" ]]
then
	echo "Could not get valid ip address for $host"
	exit 1;
fi

rev_ip=`echo $ip | sed -r 's/([0-9]+)\.([0-9]+)\.([0-9]+)\.([0-9]+)/\4.\3.\2.\1/'`

{
listed=0

for dnsbl in `cat $DNSLBL_LIST | grep -v "#"`
do
	if host -W 1 -t a $rev_ip.$dnsbl >/dev/null 2>&1
	then
		echo $host blacklisted on $dnsbl
		host -t txt $rev_ip.$dnsbl | sed "s/^/$host dnsbl_details /"
		listed=`expr $listed + 1`
	fi
done
echo $host dnsbl_status $listed
} | zabbix_sender -z 127.0.0.1 -r -i -


echo 1
exit 0


