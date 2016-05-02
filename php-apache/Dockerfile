FROM php:5.6-apache

COPY php.ini /usr/local/etc/php/

# install php dependency
RUN apt-get update && apt-get install -y \
      vim \
      git \
      curl \
      libmcrypt-dev \
      libicu-dev \
      zlib1g-dev \
      php5-intl \
      libfreetype6-dev \
      libjpeg62-turbo-dev \
      libpng12-dev \
  && docker-php-ext-install -j$(nproc) iconv mcrypt intl mysql mysqli pdo pdo_mysql mbstring exif zip \
  && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
  && docker-php-ext-install -j$(nproc) gd

RUN pecl install xdebug apcu-4.0.10 && \
    docker-php-ext-enable xdebug apcu

# change default apache folder
RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/apache2.conf

# change php timezone
RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/php.ini

# enable mod_rewrite apache
RUN a2enmod rewrite

# add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# execute composer without Xdebug
RUN echo "alias composer='php -n -dextension=zip.so -dextension=gd.so /usr/local/bin/composer'" >> ~/.bashrc \
    && echo "export TERM=xterm" >> ~/.bashrc \
    && echo -e "alias xphp='XDEBUG_CONFIG=\"idekey=PHPSTORM\" \
            php \
            -dxdebug.idekey=PHPSTORM \
            -dxdebug.remote_host=172.17.0.1 \
            -dxdebug.remote_port=9000 \
            -dxdebug.default_enable=1 \
            -dxdebug.remote_enable=1'" >> ~/.bashrc

#change www-data`s UID inside a Dockerfile
RUN usermod -u 1000 www-data

# Xdebug config
RUN echo -e "\
xdebug.var_display_max_depth = 10\n \
xdebug.var_display_max_children = 256\n \
xdebug.var_display_max_data = 1024\n \

xdebug.default_enable=1\n \
xdebug.remote_enable=1\n \
xdebug.remote_host=172.17.0.1\n \
xdebug.remote_port=9000\n \
xdebug.idekey=PHPSTORM\n \

xdebug.profiler_output_dir=/var/www/html\n \
xdebug.profiler_enable_trigger=1\
" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini


EXPOSE 80
