# Move the SSH key to Authorized Keys and ensure permissions
mkdir -p /home/apjsddc/.ssh
chmod 700 /home/apjsddc/.ssh
cat /tmp/id_rsa.pub > /home/apjsddc/.ssh/authorized_keys
chmod 644 /home/apjsddc/.ssh/authorized_keys
chown -R apjsddc /home/apjsddc/.ssh
rm -rf /tmp/id_rsa.pub