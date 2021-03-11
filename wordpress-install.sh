#!/bin/bash

echo "Installing WordPress"



cd /var/www/html

if [ ! -e wp-config.php ]; then

cp wp-config-sample.php wp-config.php

: "${WORDPRESS_DB_HOST:=mysql}"
: "${WORDPRESS_DB_USER:=root}"
: "${WORDPRESS_DB_PASSWORD:=}"
: "${WORDPRESS_DB_NAME:=wordpress}"
: "${WORDPRESS_DB_CHARSET:=utf8}"
: "${WORDPRESS_DB_COLLATE:=}"
: "${WORDPRESS_TABLE_PREFIX:=wp_}"


uniqueEnvs=(
		WORDPRESS_AUTH_KEY
		WORDPRESS_SECURE_AUTH_KEY
		WORDPRESS_LOGGED_IN_KEY
		WORDPRESS_NONCE_KEY
		WORDPRESS_AUTH_SALT
		WORDPRESS_SECURE_AUTH_SALT
		WORDPRESS_LOGGED_IN_SALT
		WORDPRESS_NONCE_SALT
	)
envs=(
    WORDPRESS_DB_HOST
    WORDPRESS_DB_USER
    WORDPRESS_DB_PASSWORD
    WORDPRESS_DB_NAME
    WORDPRESS_DB_CHARSET
    WORDPRESS_DB_COLLATE
    WORDPRESS_TABLE_PREFIX
)

set_config() {
    key="$1"
    value="$2"
    var_type="${3:-string}"
    sed -ri -e "s/'$1'/\1$(sed_escape_rhs "'$value'")\3/" wp-config.php
}


sed_escape_lhs() {
    echo "$@" | sed -e 's/[]\/$*.^|[]/\\&/g'
}
sed_escape_rhs() {
    echo "$@" | sed -e 's/[\/&]/\\&/g'
}

set_config 'WORDPRESS_DB_HOST' "$WORDPRESS_DB_HOST"
set_config 'WORDPRESS_DB_USER' "$WORDPRESS_DB_USER"
set_config 'WORDPRESS_DB_PASSWORD' "$WORDPRESS_DB_PASSWORD"
set_config 'WORDPRESS_DB_NAME' "$WORDPRESS_DB_NAME"
set_config 'WORDPRESS_DB_CHARSET' "$WORDPRESS_DB_CHARSET"
set_config 'WORDPRESS_DB_COLLATE' "$WORDPRESS_DB_COLLATE"
set_config 'WORDPRESS_TABLE_PREFIX' "$WORDPRESS_TABLE_PREFIX"


for unique in "${uniqueEnvs[@]}"; do
    set_config "$unique" "$(head -c1m /dev/urandom | sha1sum | cut -d' ' -f1)"
done

fi

# Copy new Wordpress files
cp -R /temp/wordpress/* /var/www/html/

# Copy our custom config file
cp /temp/wp-config-sample.php /var/www/html/

# Copy our includes themes and plugins
cp -R /usr/src/wordpress/wp-content/* /var/www/html/wp-content/

find /var/www/html/wp-content/ -name "__MACOSX*" -exec rm -rf {} \;
find /var/www/html/wp-content/ -name ".git" -exec rm -rf {} \;

chmod -R 777 /var/www/html/wp-content/*

rm -R /usr/src/wordpress
rm -R /temp
