#!/bin/sh
if ls /etc/init.d/cloudera-scm-* &> /dev/null; then
  for SERVICE_SCRIPT in /etc/init.d/cloudera-scm-*; do
    sudo $SERVICE_SCRIPT stop
  done
fi
sleep 5

