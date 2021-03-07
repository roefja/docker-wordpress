# Docker WordPress

An Nginx based WordPress image with php-fpm enabled for auto caching

Includes the following default plugin:
- nginx-cache (Set the folder to /etc/nginx/cache to auto purge the cache)
- classic-editor (Because we prefer it over the Gutenberg editor)

We have removed Askimet and Hello Dolly from the WordPress installation

Nginx will be running on port **8080**

**Please notice:** 
PHP version 8 is used in all images, unless php-7 is includes in the tag (ex: php-7-v-5.6.2)

## Available environment variables

- WORDPRESS_DB_HOST _Default: mysql_
- WORDPRESS_DB_USER _Default: wordpress_
- WORDPRESS_DB_PASSWORD _Default: empty_
- WORDPRESS_DB_NAME _Default: wordpress_
- WORDPRESS_DB_CHARSET _Default: utf-8_
- WORDPRESS_DB_COLLATE _Default: empty_
- WORDPRESS_TABLE_PREFIX _Default: wp_