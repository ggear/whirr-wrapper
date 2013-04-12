#!/bin/sh
if ls /etc/init.d/cloudera-scm-server-db &> /dev/null; then
  sudo /etc/init.d/cloudera-scm-server-db start
  sleep 5
fi
if ls /etc/init.d/cloudera-scm-server &> /dev/null; then
  sudo /etc/init.d/cloudera-scm-server start
  for ID in {180..1}; do
    if [ $(curl -sI -u admin:admin "http://localhost:7180" | grep "HTTP/1.1 200 OK" | wc -l) -gt 0 ]; then
      break   
    fi
    sleep 1
  done
fi
if ls /etc/init.d/cloudera-scm-agent &> /dev/null; then
  sudo /etc/init.d/cloudera-scm-agent start
  sleep 5
fi
