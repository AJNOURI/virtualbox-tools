#!/bin/bash
# $1 = VM name
# $2 interface number


if [ "$#" -ne 2 ]
  then
    echo "Wrong parameters"
    echo "Usage: `basename $0` <vm_name> <number_of_interfaces>"
    echo ""
    exit 0
else 
      for (( i=1;i<=$2;i=i+1 )); do
        VBoxManage modifyvm $1 --nic$i generic
        VBoxManage modifyvm $1 --nicpromisc$i allow-all
        VBoxManage modifyvm $1 --nictype$i 82545EM
        VBoxManage modifyvm $1 --cableconnected$i on
        VBoxManage modifyvm $1 --nicgenericdrv$i UDPTunnel
        VBoxManage modifyvm $1 --nicproperty$i dest=127.0.0.1
     done
fi
