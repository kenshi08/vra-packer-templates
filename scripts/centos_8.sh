yum install -y cloud-init perl open-vm-tools bash-completion yum-utils
cloud-init clean
yum clean all
sed -ie 's/disable_vmware_customization: false/disable_vmware_customization: true/g' /etc/cloud/cloud.cfg
echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg.d/99-disable-network-config.cfg

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
           ╙╬╦╦╩╜ ╓╬╩     ╦╬╜            Code Stream Packer Build - CentOS 8
                ╔╬╩    ╓╦╩╙
                ╩╬╖  ╓╬╩
                  ╙╩╩╨
MOTD
