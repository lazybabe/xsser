FROM php:fpm

VOLUME ["/www/xsser", "/home/logs/php/xsser", "/tmp"]

COPY ./src /www/xsser/
COPY ./conf/online/php.ini /usr/local/etc/php/php.ini
COPY ./conf/online/fpm.conf /usr/local/etc/php-fpm.d/xsser.conf

