zabbix_dnsbl
============
External script and template for Zabbix to check if host is blacklisted.

How it works
============
This script works as listed below:

* get the ip address of the host
* reverse the address ip
* append the name of blacklist to reversed ip address
* resolve the resulting name in DNS

If the record exitsts - Your host is blacklisted. 

Requirements
============
zabbix_sender

How to install
==============
Here are the steps to install it:
* download check_dnsbl.sh, dnsbl.txt and zbx_export_templates.xml
* put check_dnsbl.sh and dnsbl.txt into ExternalScript location (You will find it in zabbix_server configuration)
* make check_dnsbl.sh executable (chmod +x check_dnsbl.sh)
* import zabbix_template (zbx_export_templates.xml) into zabbix
* link template to You servers

Feedback
========
Feel free to send bugs reports and feature request here:
* https://github.com/sq4ind/zabbix_dnsbl/issues
* mail: sq4ind[AT]gmail.com