#! /bin/bash
sudo su -
yum update
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello 1" > /var/www/html/index.html