FROM roefja/nginx-php

USER root

# Add Wordpress modules
RUN apk --no-cache add php8-exif php8-fileinfo php8-zip php8-iconv php8-pecl-imagick php8-soap

# Copy files from wordpress-builder
COPY --from=wordpress-builder /temp /temp
COPY --from=wordpress-builder /etc/nginx/conf.d/ /etc/nginx/conf.d/
COPY --from=wordpress-builder /etc/supervisor/conf.d/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY --from=wordpress-builder /usr/src/wordpress/ /usr/src/wordpress/

USER nginx