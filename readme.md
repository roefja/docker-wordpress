# Docker Wordpress

An Nginx based Wordpress image with php-fpm enabled for auto caching

Includes the following default plugin:
- nginx-cache (Set the folder to /etc/nginx/cache to auto purge the cache)
- classic-editor (Because we prefer it over the Gutenberg editor)
- wp-mail-smtp (Usefull plugin for sending mail and making sure that it actually arrives)

We have removed Askimet and Hello Dolly from the Wordpress installation



### TODO:
- [ ] Docker examples
- [ ] Docker-compose example