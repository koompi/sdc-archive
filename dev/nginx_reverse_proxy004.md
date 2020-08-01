```
DEV: 004
Title: How to config nginx reverse_proxy
Author: Heng Hongsea
Status: Active
Create: 2020-06-15
Update: NA
version: 0.1.0
```

# How to config nginx reverse proxy

### Intro
In the Linux operating system, a Reverse Proxy acts as a link between the host (client) and the server. It takes up client requests and passes them on to other servers and finally delivers the server’s response to the client, appearing as if they originated from the proxy server itself. In this tutorial, we’ll show how to configure reverse proxy.

### Scenario:
Now we have example website run http://localhost:8080 and we want pass it ot domain www.example.com via reverse proxy. We will configure nginx reverse proxy on archlinux.

### Solution:

1. Install package
	```
	$ sudo pacman -Sy nginx
	```
2. Config file /etc/nginx/nginx.conf
		
		user http;
		worker_processes auto;
		worker_cpu_affinity auto;
		#include /etc/nginx/modules-enabled/*.conf;

		events {
		    multi_accept on;
		    worker_connections 1024;
		}

		http {
		    charset utf-8;
		    sendfile on;
		    tcp_nopush on;
		    tcp_nodelay on;
		    server_tokens off;
		    log_not_found off;
		    types_hash_max_size 4096;
		    client_max_body_size 16M;

		    # MIME
		    include mime.types;
		    default_type application/octet-stream;

		    # logging
		    access_log /var/log/nginx/access.log;
		    error_log /var/log/nginx/error.log warn;

		    # SSL
		    ssl_session_timeout 1d;
		    ssl_session_cache shared:SSL:10m;
		    ssl_session_tickets off;

		    # Diffie-Hellman parameter for DHE ciphersuites
		    ssl_dhparam /etc/nginx/dhparam.pem;

		    # Mozilla Intermediate configuration
		    ssl_protocols TLSv1.2 TLSv1.3;
		    ssl_ciphers ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-CHACHA20-POLY1305:ECDHE-RSA-CHACHA20-POLY1305:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES256-GCM-SHA384;

		    # OCSP Stapling
		    ssl_stapling on;
		    ssl_stapling_verify on;
		    resolver 1.1.1.1 1.0.0.1 8.8.8.8 8.8.4.4 208.67.222.222 208.67.220.220 valid=60s;
		    resolver_timeout 2s;

		    # load configs
		    include /etc/nginx/sites-enabled/*.conf;
		}	

3. Configure nginx reverse proxy.

	Create directory `sites-avaiable` and `sites-enabled`
	```
	$ sudo mkdir -p /etc/nginx/sites-avaiable /etc/nginx/sites-enabled	
	$ cd /etc/nginx/sites-avaiable/ & touch www.example.com.conf
	```

	Add config file /etc/nginx/sites-avaiable/www.example.com.conf
	```
	server {
       listen 80;
       listen [::]:80;

       server_name www.example.com;
       location / {
	       proxy_pass http://localhost:8080;
               proxy_set_header Upgrade $http_upgrade;
               proxy_set_header Connection 'upgrade';
               proxy_set_header Host $host;
               proxy_cache_bypass $http_upgrade;
	       }
	}
	```

	Link from sites-avaiable to sites-enabled, and then restart service nginx.

	```
	$ sudo ln -s /etc/nginx/sites-avaiable/www.example.com.conf /etc/nginx/sites-enabled/
	$ sudo nginx -t
	$ sudo systemctl restart nginx
	```

