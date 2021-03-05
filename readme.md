# Docker WordPress

An Nginx based WordPress image with php-fpm enabled for auto caching

Includes the following default plugin:
- nginx-cache (Set the folder to /etc/nginx/cache to auto purge the cache)
- classic-editor (Because we prefer it over the Gutenberg editor)

We have removed Askimet and Hello Dolly from the WordPress installation

Nginx will be running on port 8080