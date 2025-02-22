FROM nginx:1.27.4-alpine-slim

# Install Python and PIP
RUN apk add --no-cache python3 py3-pip

# Remove "externally managed" tag so pip can manage packages globally
RUN rm /usr/lib/python*/EXTERNALLY-MANAGED && python3 -m ensurepip

# Install Certbot
RUN pip3 install certbot certbot-nginx

# Setup periodic renewal checks
RUN cat <<EOF > /etc/crontabs/root
# min   hour    day     month   weekday command
*/15    *       *       *       *       run-parts /etc/periodic/15min
0       *       *       *       *       run-parts /etc/periodic/hourly
0       2       *       *       *       run-parts /etc/periodic/daily
0       3       *       *       6       run-parts /etc/periodic/weekly
0       5       1       *       *       run-parts /etc/periodic/monthly
0       12      *       *       *       certbot renew
EOF

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose Nginx port
EXPOSE 80 443

# Set entrypoint
CMD ["/entrypoint.sh"]