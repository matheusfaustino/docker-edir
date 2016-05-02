php:
	cd php-apache && docker build -t php56-apache .

mysql:
	cd mysql && docker build -t mysql56 .

elastic:
	cd elasticsearch && docker build -t elasticsearch23 .
