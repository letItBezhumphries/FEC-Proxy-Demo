#!/bin/bash

set -ex

apt-get update

groupadd proxy-demo

useradd -d /FEC-Proxy-Demo -s /bin/false -g proxy-demo proxy-demo

chown -R proxy-demo:proxy-demo /home/ubuntu/FEC-Proxy-Demo

echo 'user www-data;
worker_processes auto;
pid /run/nginx.pid;
events {
        worker_connections 768;
        # multi_accept on;
}
http {
  server {
    listen 80;
    location / {
      proxy_pass http://localhost:3000/;
      proxy_set_header Host $host;
      proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
  }
}' > /etc/nginx/nginx.conf

service nginx restart

cd /home/ubuntu/FEC-Proxy-Demo
npm install

echo '[Service]
ExecStart=/usr/bin/nodejs /home/ubuntu/FEC-Proxy-Demo/server/server.js
Restart=always
StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=proxy-demo
User=proxy-demo
Group=proxy-demo
Environment=NODE_ENV=production
[Install]
WantedBy=multi-user.target' > /etc/systemd/system/proxy-demo.service

systemctl enable proxy-demo
systemctl start proxy-demo