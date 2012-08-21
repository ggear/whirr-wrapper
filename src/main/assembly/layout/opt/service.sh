#!/bin/sh

function line_item() {
  echo "" && echo "----" && echo "" 
}

line_item
line_item
/bin/hostname
line_item
if ls /etc/init.d/hadoop-* &> /dev/null; then for service in /etc/init.d/hadoop-*; do echo "" && echo $service; sudo $service status || echo " !!! SERVICE NOT RUNNING !!! "; done; fi
if ls /etc/init.d/cloudera-* &> /dev/null; then for service in /etc/init.d/cloudera-*; do echo "" && echo $service; sudo $service status || echo " !!! SERVICE NOT RUNNING !!! "; done; fi
line_item
line_item
 