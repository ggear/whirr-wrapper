#!/bin/sh

function line_item_header() {
  echo "-------------------------------------------------------------------------------" && echo "$1" && echo "-------------------------------------------------------------------------------" && echo "" 
}

function line_item_cmd() {
  line_item_header "$1"
  $1
  echo "" 
}

SERVICE_CMD='start'
SERVICE_PREFIX='hadoop'

echo ""

if ls /etc/init.d/$SERVICE_PREFIX-* &> /dev/null; then
  for SERVICE_SCRIPT in /etc/init.d/$SERVICE_PREFIX-*; do
    line_item_cmd "sudo $SERVICE_SCRIPT $SERVICE_CMD"
  done
fi 

echo ""
