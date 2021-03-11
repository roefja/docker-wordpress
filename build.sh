#!/bin/bash

docker build -q -t wordpress-builder -f Dockerfile.wordpress-builder .

docker build -q  -t roefja/wordpress .
docker build -q -t roefja/wordpress:php-7 -f Dockerfile.php-7 .

docker tag roefja/wordpress roefja/wordpress:php-8