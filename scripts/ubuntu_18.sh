
#!/bin/bash

sudo apt-get install -y cloud-init perl

sudo sed -i 's/^disable_root: true/disable_root: false/g' /etc/cloud/cloud.cfg
sudo sed -i '/^preserve_hostname: false/a\disable_vmware_customization: true' /etc/cloud/cloud.cfg

sudo sed -i '/^disable_vmware_customization: true/a\datasource_list: [OVF]' /etc/cloud/cloud.cfg

sed -i '/^disable_vmware_customization: true/a\network:' /etc/cloud/cloud.cfg
sed -i '/^network:/a\  config: disabled' /etc/cloud/cloud.cfg

sudo sed -i 's/D/#&/' /usr/lib/tmpfiles.d/tmp.conf

sudo sed -i '/^After=vgauthd.service/a\After=dbus.service' /lib/systemd/system/open-vm-tools.service

sudo touch /etc/cloud/cloud-init.disabled

cat <<EOF > /etc/cloud/runonce.sh
#!/bin/bash
  sudo rm -rf /etc/cloud/cloud-init.disabled
  sudo systemctl restart cloud-init.service
  sudo systemctl restart cloud-config.service
  sudo systemctl restart cloud-final.service
  sudo systemctl disable runonce
  sudo touch /tmp/cloud-init.success
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

sudo touch /etc/cloud/cloud-init.disabled

sudo chmod +x /etc/cloud/runonce.sh

sudo systemctl daemon-reload

sudo systemctl enable runonce.service

# Remove temporary files
rm -rf /tmp/*
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
           ╙╬╦╦╩╜ ╓╬╩     ╦╬╜            Code Stream Packer Build - Ubuntu 18.04
                ╔╬╩    ╓╦╩╙
                ╩╬╖  ╓╬╩
                  ╙╩╩╨
MOTD
