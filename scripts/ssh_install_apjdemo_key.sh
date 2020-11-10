# Move the SSH key to Authorized Keys and ensure permissions
mkdir -p /home/apjdemo/.ssh
chmod 700 /home/apjdemo/.ssh
cat /tmp/id_rsa.pub > /home/apjdemo/.ssh/authorized_keys
chmod 644 /home/apjdemo/.ssh/authorized_keys
chown -R apjdemo /home/apjdemo/.ssh
rm -rf /tmp/id_rsa.pub