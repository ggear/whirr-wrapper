#!/bin/sh

function line_item_header() {
  echo "-------------------------------------------------------------------------------" && echo "$1" && echo "-------------------------------------------------------------------------------" && echo "" 
}

function line_item_ip() {
  cat $TMP_FILE | grep $1 | cut -d: -f2 | awk '{print $3}'
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

line_item_header "CM Servers"
line_item_url "cmserver" "7180"
echo ""
line_item_ssh "cmserver"
echo ""

line_item_header "CM Nodes"
line_item_host "cmnode"
echo ""
line_item_ssh "cmnode"
echo ""

line_item_header "CDH Name Nodes"
line_item_url "hadoop-namenode" "50070"
echo ""
line_item_ssh "hadoop-namenode"
echo ""

line_item_header "CDH Job Trackers"
line_item_url "hadoop-jobtracker" "50030"
echo ""
line_item_ssh "hadoop-jobtracker"
echo ""

line_item_header "CDH Data Nodse"
line_item_url "hadoop-datanode" "50010"
echo ""
line_item_ssh "hadoop-datanode"
echo ""

line_item_header "CDH Task Trackers"
line_item_url "hadoop-tasktracker" "50060"
echo ""
line_item_ssh "hadoop-tasktracker"
echo ""

line_item_header ""
echo ""

rm -rf $TMP_DIR