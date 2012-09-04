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

line_item_cmd '/bin/date'  
line_item_cmd '/usr/bin/ntpstat'

echo ""

