#!/bin/bash

#Install haproxy,net-tools
yum install haproxy net-tools -y

#Enable haproxy to start at bootup
systemctl enable haproxy

#Config
cat > /etc/haproxy/haproxy.cfg <<EOD
global
    daemon
    maxconn 256
defaults
    mode http
    timeout connect 5000ms
    timeout client 50000ms
    timeout server 50000ms
frontend http-in
    bind *:80
    default_backend webservers
backend webservers
    balance roundrobin
    # Poor-man's sticky
    # balance source
    # JSP SessionID Sticky
    # appsession JSESSIONID len 52 timeout 3h
    option httpchk
    option forwardfor
    option http-server-close
    server web1 172.28.33.11:80 maxconn 32 check
    server web2 172.28.33.12:80 maxconn 32 check
listen admin
    bind *:8080
    stats enable
EOD

#Start haproxy
systemctl start haproxy

#haproxy status
systemctl status haproxy
