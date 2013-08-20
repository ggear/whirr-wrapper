#!/bin/sh
sudo mkdir -p /opt/cloudera/parcels
sudo /bin/sed -i -e "s|parcel_dir=.*|# parcel_dir=|" /etc/cloudera-scm-agent/config.ini
#sudo mkdir -p /data0/manager/parcels/parcel-runtime
#sudo /bin/sed -i -e "s|# parcel_dir=.*|parcel_dir=/data0/manager/parcels/parcel-runtime|" /etc/cloudera-scm-agent/config.ini		
sudo /sbin/service cloudera-scm-agent restart
