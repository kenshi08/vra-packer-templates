#!/bin/bash
#clear audit logs
if [ -f /var/log/audit/audit.log ]; then
cat /dev/null > /var/log/audit/audit.log
fi
if [ -f /var/log/wtmp ]; then
cat /dev/null > /var/log/wtmp
fi
if [ -f /var/log/lastlog ]; then
cat /dev/null > /var/log/lastlog
fi
#cleanup persistent udev rules
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
rm /etc/udev/rules.d/70-persistent-net.rules
fi
#cleanup /tmp directories
rm -rf /tmp/*
rm -rf /var/tmp/*
#cleanup current ssh keys
#rm -f /etc/ssh/ssh_host_*
#cat /dev/null > /etc/hostname
#cleanup apt
yum clean all
#Clean Machine ID
truncate -s 0 /etc/machine-id
rm /var/lib/dbus/machine-id
ln -s /etc/machine-id /var/lib/dbus/machine-id
#Clean Cloud-init
cloud-init clean --logs --seed
#Disabled Cloud-init
touch /etc/cloud/cloud-init.disabled
systemctl enable runonce
#cleanup shell history
echo > ~/.bash_history
history -cw