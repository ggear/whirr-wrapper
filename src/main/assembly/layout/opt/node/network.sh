#!/bin/sh

function line_item() {
  echo "" && echo "----" && echo "" 
}

function line_item_cmd() {
  line_item && echo "$1:" && $1 
}

function line_item_file() {
  line_item && echo "$1:" && [ -f "$1" ] && cat "$1"
}

line_item
line_item
line_item
line_item_cmd '/bin/uname -a'
line_item_cmd '/bin/hostname -f'
line_item_cmd '/sbin/ifconfig eth0'
line_item_file '/etc/hosts'
line_item_file '/etc/sysconfig/network'
line_item_file '/etc/hostname'
line_item_cmd '/usr/bin/dig +short '`hostname -f`
line_item_cmd '/bin/traceroute '`hostname -f`
line_item_cmd '/bin/ping -c 3 -i 1 -R '`hostname -f`
line_item_cmd '/usr/bin/host '`hostname -f`
line_item_cmd '/usr/bin/host '`/sbin/ifconfig eth0 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'`
line_item
line_item
line_item
line_item