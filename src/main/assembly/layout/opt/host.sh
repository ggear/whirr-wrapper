#!/bin/sh
HOST=$(/bin/hostname)
HOST_IP=$(/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
HOST_IP_PRIVATE=$(/sbin/ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}')
echo -e "$HOST_IP\t$HOST"
