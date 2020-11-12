yum install -y cloud-init perl open-vm-tools bash-completion yum-utils
cloud-init clean
yum clean all

sed -i 's/^disable_root: 1/disable_root: 0/g' /etc/cloud/cloud.cfg
sed -i 's/^ssh_pwauth:   0/ssh_pwauth:   1/g' /etc/cloud/cloud.cfg

sed -i 's/^disable_vmware_customization: false/disable_vmware_customization: true/g' /etc/cloud/cloud.cfg
sed -i '/^disable_vmware_customization: true/a\datasource_list: [OVF]' /etc/cloud/cloud.cfg

sed -i '/^disable_vmware_customization: true/a\network:' /etc/cloud/cloud.cfg
sed -i '/^network:/a\  config: disabled' /etc/cloud/cloud.cfg

sed -i 's/^SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

SOURCE_TEXT="v /tmp 1777 root root 10d"
DEST_TEXT="#v /tmp 1777 root root 10d"
sed -i "s@${SOURCE_TEXT}@${DEST_TEXT}@g" /usr/lib/tmpfiles.d/tmp.conf
sed -i "s/\(^.*10d.*$\)/#\1/" /usr/lib/tmpfiles.d/tmp.conf

###Add After=dbus.service to vmtoolsd. ### 
sed -i '/^After=vgauthd.service/a\After=dbus.service' /usr/lib/systemd/system/vmtoolsd.service

touch /etc/cloud/cloud-init.disabled

cat <<EOF > /etc/cloud/runonce.sh
#!/bin/bash
  rm -rf /etc/cloud/cloud-init.disabled
  sudo systemctl restart cloud-init.service
  sudo systemctl restart cloud-config.service
  sudo systemctl restart cloud-final.service
  sudo systemctl disable runonce
  touch /tmp/cloud-init.complete
EOF

cat <<EOF > /etc/systemd/system/runonce.service
[Unit]
Description=Run once
Requires=network-online.target
Requires=cloud-init-local.service
After=network-online.target
After=cloud-init-local.service
[Service]
###wait for vmware customization to complete, avoid executing cloud-init at the first startup.###
ExecStartPre=/bin/sleep 30
ExecStart=/etc/cloud/runonce.sh
[Install]
WantedBy=multi-user.target
EOF

chmod +x /etc/cloud/runonce.sh

systemctl daemon-reload

systemctl enable runonce.service

cat << MOTD > /etc/motd
                  ╓╦╦╖
                ╦╬╜  ╙╬╦
                ╚╬╦    ╙╬╦
           ╓╦╦╦╦  ╙╬╦    ╙╬╦             Built by:
         ╓╬╩    ╚╬╖ ╙╬╦     ╚╬╖                 ____            _ _
       ╓╦ └╬╦     ╙╬╦ ╙╬╦     ╙╬╦        __   _|  _ \\ ___  __ _| (_)_______
     ╔╬╨╙╬╦  ╚╬╖    ╙╬╦  ╚╬╖    ╙╬╦      \\ \\ / / |_) / _ \\/ _\` | | |_  / _ \\
   ╦╬╜    ╙╬╦  ╙╬╦    ╙╬╦  ╙╬╦    ╙╬╦     \\ V /|  _ <  __/ (_| | | |/ /  __/
 ╔╬╙        └╩╦╖ ╙╬╦    ╙╩╦╖ ╙╬╦    ╙╬╦    \\_/ |_| \\_\\___|\\__,_|_|_/___\\___|    _   _
 ╚╬          ╦╬╜ ╓╬╩     ╦╬╜ ╓╬╩     ╬╩     / \\  _   _| |_ ___  _ __ ___   __ _| |_(_) ___  _ __
  └╚╦╖     ╦╬╙ ╓╬╩    ┌╦╩╙ ╔╬╩    ╓╦╩╙     / _ \\| | | | __/ _ \\| '_ \` _ \\ / _\` | __| |/ _ \\| '_ \\
     ╚╬╦╓╬╩╙ ╔╬╨    ╓╬╩  ╔╬╨    ╓╬╩─      / ___ \\ |_| | || (_) | | | | | | (_| | |_| | (_) | | | |
       ╙╩  ╦╬╜    ╓╬╩  ╦╬╜    ╓╬╩        /_/   \\_\\__,_|\\__\\___/|_| |_| |_|\\__,_|\\__|_|\\___/|_| |_|
         ╘╬╬    ╔╬╨ ╓╦╩     ╔╬╨
           ╙╬╦╦╩╜ ╓╬╩     ╦╬╜            Code Stream Packer Build - CentOS 7
                ╔╬╩    ╓╦╩╙
                ╩╬╖  ╓╬╩
                  ╙╩╩╨
MOTD