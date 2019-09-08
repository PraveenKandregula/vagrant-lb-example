#!/bin/bash

#Install net-tools and httpd
yum install net-tools httpd -y

#Place index.cgi
touch /var/www/cgi-bin/index.cgi
cat > /var/www/cgi-bin/index.cgi <<EOD
#!/bin/bash
echo "Content-type: text/html"
echo ""
echo "<html><head><title>Bash as CGI"
echo "</title></head><body>"

echo "<h1>Hello world. This response is returned by $(ifconfig | grep inet | grep 172 | awk '{print $2}')</h1>"
echo ""

echo "</body></html>"
EOD

chmod +x /var/www/cgi-bin/index.cgi
#Start httpd
systemctl start httpd

#httpd status
systemctl status httpd
