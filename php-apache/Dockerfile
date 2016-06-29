FROM php:5.6-apache

COPY php.ini /usr/local/etc/php/

# install php dependency
RUN apt-get update && apt-get install -y \
      bash-completion \
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
  && docker-php-ext-install -j$(nproc) gd \
  && docker-php-ext-install -j$(nproc) calendar

RUN pecl install xdebug apcu-4.0.10 && \
    docker-php-ext-enable xdebug apcu

RUN cd / && git clone git://github.com/twigphp/Twig.git \
    && cd Twig/ext/twig \
    && phpize \
    && ./configure \
    && make \
    && make install \
    && docker-php-ext-enable twig

# change default apache folder
RUN sed -i 's|/var/www/html|/var/www/html/web|g' /etc/apache2/apache2.conf

# change php timezone
RUN echo "date.timezone = America/Sao_Paulo" >> /usr/local/etc/php/php.ini

# enable mod_rewrite apache
RUN a2enmod rewrite

# add composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# add bash config file
COPY bashrc.template /root

# call that file into bashrc
RUN echo ". ~/bashrc.template" >> ~/.bashrc

#change www-data`s UID inside a Dockerfile
RUN usermod -u 1000 www-data

# Xdebug config
RUN echo "\
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
