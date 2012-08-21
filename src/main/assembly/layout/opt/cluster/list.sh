#!/bin/sh

function line_item() {
  echo "" && echo "----" && echo "" 
}

TMP_DIR_TEMPLATE="/tmp/`echo ${0%/} | awk -F/ '{print \$NF}'`.XXXXXXXXXXXXXX"
TMP_DIR=`mktemp -d $TMP_DIR_TEMPLATE`
TMP_FILE="$TMP_DIR/whirr_list-cluster.txt"

line_item
echo -n "Querying cluster ... "
whirr list-cluster | grep -v "Running " > $TMP_FILE
echo "done"

line_item
echo "Whirr Cluster:" && echo ""
cat $TMP_FILE | grep -v "Running "

line_item
echo "CM Server IP:" && echo ""
cat $TMP_FILE | grep "cmserver" | cut -d: -f2 | awk '{print $3}'

line_item
echo "CM Server URL:" && echo ""
echo 'http://'`dig +short -x $(cat  $TMP_FILE | grep cmserver| cut -d: -f2 | awk '{print $3}') | head -c -2`':7180'

line_item
echo "CDH Node IPs:" && echo ""
cat $TMP_FILE | grep "cmnode" | cut -d: -f2 | awk '{print $3}'

line_item

rm -rf $TMP_DIR