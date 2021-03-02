FROM roefja/nginx-php

USER root

# Add Wordpress modules
RUN apk --no-cache add php7-exif php7-fileinfo php7-imagick php7-zip php7-iconv

# Get our default plugins
RUN mkdir -p /usr/src/wordpress/wp-content/plugins/ && \
  chown -R nginx.nginx /usr/src/wordpress/wp-content/plugins/ && \
  cd /usr/src/wordpress/wp-content/plugins/ && \ 
  wget https://downloads.wordpress.org/plugin/wp-mail-smtp.zip && \
  wget https://downloads.wordpress.org/plugin/classic-editor.zip && \
  wget https://downloads.wordpress.org/plugin/nginx-cache.zip && \
  cd /usr/src/wordpress/wp-content/plugins/ && sh -c 'unzip -q "*.zip"' && rm *.zip

# Add application
WORKDIR /var/www/html

# Copy WordPress install script
COPY ./wordpress-install.sh /temp/

# Configure supervisord
COPY config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Download and unzip WordPress
RUN cd /temp && wget https://wordpress.org/latest.zip && unzip latest.zip && mv wordpress/* /var/www/html

# Copy our modified config-sample file
COPY --chown=nginx:nginx config/wp-config.php /var/www/html/wp-config-sample.php

# Remove default wordpress plugins
RUN cd /var/www/html/wp-content/plugins/ && rm hello.php && rm -R akismet

RUN chmod 777 -R /var/www/html/

USER nginx