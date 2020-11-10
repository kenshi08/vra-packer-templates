
apt-get install -y cloud-init
sed -ie 's/disable_vmware_customization: false/disable_vmware_customization: true/g' /etc/cloud/cloud.cfg
echo 'network: {config: disabled}' > /etc/cloud/cloud.cfg
# Remove temporary files
rm -rf /tmp/*


mv /etc/motd /etc/motd-backup
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
           ╙╬╦╦╩╜ ╓╬╩     ╦╬╜            Code Stream Packer Build - Ubuntu 19.10
                ╔╬╩    ╓╦╩╙
                ╩╬╖  ╓╬╩
                  ╙╩╩╨
MOTD
