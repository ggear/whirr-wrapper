#!/bin/sh

function line_item_header() {
  echo "-------------------------------------------------------------------------------" && echo "$1" && echo "-------------------------------------------------------------------------------" && echo "" 
}

function line_item_line() {
  cat $TMP_FILE | grep $1
}

function line_item_ip() {
   line_item_line $1 | cut -d: -f2 | awk '{print $3}'
}

function line_item_host() {
  line_item_ip $1 | xargs -n 1 -I £ dig +short -x £ | sed 's/\(.*\)./\1/'
}

function line_item_url() {
  line_item_host $1 | xargs -n 1 -I £ echo "http://"£":"$2"/"$3
}

function line_item_ssh() {
  line_item_host $1 | xargs -n 1 -I £ echo "ssh -o StrictHostKeyChecking=no whirr@"£
}

function line_items_host() {
	if [ $(line_item_line "$2" | wc -l) -gt 0 ]; then 
	  line_item_header "$1"
	  line_item_host "$2"
	  echo ""
	  line_item_ssh "$2"
	  echo ""
	fi
}

function line_items_url() {
  if [ $(line_item_line "$2" | wc -l) -gt 0 ]; then 
    line_item_header "$1"
    line_item_url "$2" "$3" "$4"
    echo ""
    line_item_ssh "$2"
    echo ""
  fi
}

TMP_DIR_TEMPLATE="/tmp/`echo ${0%/} | awk -F/ '{print \$NF}'`.XXXXXXXXXXXXXX"
TMP_DIR=`mktemp -d $TMP_DIR_TEMPLATE`
TMP_FILE="$TMP_DIR/whirr_list-cluster.txt"

echo ""
line_item_header ""
echo ""

line_item_header "Whirr Cluster"
whirr list-cluster | grep -v "Running " > $TMP_FILE
cat $TMP_FILE
echo ""

line_items_url "CM Servers" "cmserver" "7180" 
line_items_host "CM Nodes" "cmnode"
line_items_url "CDH Name Nodes" "hadoop-namenode" "50070" 
line_items_url "CDH Job Trackers Nodes" "hadoop-jobtracker" "50030" 
line_items_url "CDH Data Nodes" "hadoop-datanode" "50010" 
line_items_url "CDH Task Tracker Nodes" "hadoop-tasktracker" "50060" 

line_item_header ""
echo ""

rm -rf $TMP_DIR
