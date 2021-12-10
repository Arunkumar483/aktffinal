sudo su -
yum update
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "Hello 2" > /var/www/html/index.html