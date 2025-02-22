## 🚀 Nginx Alpine with Certbot for SSL Certificates

This Docker image combines the lightweight Nginx web server running on Alpine Linux with Certbot, enabling automatic generation and renewal of SSL certificates from Let's Encrypt. Secure your websites effortlessly with HTTPS, providing encryption and trust to your users.

#### Features:

+ Based on Alpine Linux for a minimal and efficient footprint.
+ Nginx web server for high-performance HTTP and reverse proxy services.
+ Certbot pre-installed for automated SSL certificate management.
+ Let's Encrypt integration for free, secure, and trusted SSL certificates.
+ Easily configure and secure your websites with HTTPS in just a few steps.

#### Usage:

+ Pull the Docker image: `docker pull galalem/nginx`
+ Customize Nginx configurations as needed.
+ Run your container with automatic SSL certificate provisioning.
+ Example Docker Run Command:

```bash
docker run -d --name nginx -p 80:80 -p 443:443 \
  -v /path/to/nginx/config:/etc/nginx/conf.d \
  -v /etc/letsencrypt:/etc/letsencrypt \
  galalem/nginx
```
> Note: Ensure proper volume mounting and configuration for your Nginx sites to enable SSL.

#### Tags:

+ `latest` : Nginx with the latest Certbot version.

Happy coding! 🛠️🔒