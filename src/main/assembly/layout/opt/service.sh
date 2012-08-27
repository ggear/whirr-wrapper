#!/bin/sh

function line_item_header() {
  echo "-------------------------------------------------------------------------------" && echo "$1" && echo "-------------------------------------------------------------------------------" && echo "" 
}

function line_item_cmd() {
  line_item_header "$1"
  $1
  echo "" 
}

echo ""

line_item_cmd '/bin/hostname -f'  

line_item_header "hadoop services"
if ls /etc/init.d/hadoop-* &> /dev/null; then for service in /etc/init.d/hadoop-*; do echo "" && echo $service; sudo $service status || echo " !!! SERVICE NOT RUNNING !!! "; done; fi
echo "" 

line_item_header "cloudera services"
if ls /etc/init.d/cloudera-* &> /dev/null; then for service in /etc/init.d/cloudera-*; do echo "" && echo $service; sudo $service status || echo " !!! SERVICE NOT RUNNING !!! "; done; fi
echo "" 

echo ""
