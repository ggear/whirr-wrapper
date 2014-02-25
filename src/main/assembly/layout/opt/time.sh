#!/bin/sh
sudo /usr/bin/yum -y install ntp
sudo /sbin/service ntpd stop
sudo /usr/sbin/ntpdate pool.ntp.org
sudo /sbin/service ntpd start
sudo /sbin/chkconfig ntpd on
sudo /bin/rm -rf /etc/localtime
sudo /bin/ln -s /usr/share/zoneinfo/Europe/London /etc/localtime

