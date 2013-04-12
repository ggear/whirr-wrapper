#!/bin/sh
HOSTS=$''
echo "$HOSTS"  | grep -v $(hostname) | sudo tee -a /etc/hosts
