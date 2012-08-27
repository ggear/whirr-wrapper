#!/bin/sh

function line_item_header() {
  echo "-------------------------------------------------------------------------------" && echo "$1" && echo "-------------------------------------------------------------------------------" && echo "" 
}

function line_item_cmd() {
  line_item_header "$1"
  $1
  echo "" 
}

function line_item_file() {
  line_item_header "$1"
  [ -f "$1" ] && cat "$1"
  echo "" 
}

echo ""

line_item_cmd '/bin/hostname -f'  
line_item_file '/etc/hosts'
line_item_file '/etc/sysconfig/network'
line_item_file '/etc/hostname'
line_item_cmd '/bin/uname -a'
line_item_cmd '/sbin/ifconfig'
line_item_cmd '/usr/bin/dig +short '`hostname -f`
line_item_cmd '/bin/traceroute '`hostname -f`
line_item_cmd '/bin/ping -c 3 -i 1 -R '`hostname -f`
line_item_cmd '/usr/bin/host '`hostname -f`
line_item_cmd '/usr/bin/host '`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`

echo ""
