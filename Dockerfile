# Ubuntu 16.04 Install
FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive
ENV COMPOSER_ALLOW_SUPERUSER=1

# Initial update/upgrade
RUN apt-get -y update && \
    apt-get -y upgrade

# Dependencies/general installs
RUN apt-get -y install git && \
    apt-get -y install zip unzip && \
    apt-get -y install wget curl && \
    apt-get -y install python3-setuptools && \
    apt-get -y install nano logrotate

# LAMP Setup
RUN apt-get -y install apache2 php-xdebug libapache2-mod-php && \
    apt-get -y install mysql-server php-mysql && \
    apt-get -y install php-apcu php-gd php-xml php-mbstring php-gettext php-zip php-curl

# Composer Install
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

# Symfony Install
RUN wget https://get.symfony.com/cli/installer -O - | bash
ENV PATH="/root/.symfony/bin:${PATH}"

# Setting path and copying local files to it
WORKDIR /usr/src/app
COPY /application .

# Install application dependencies
RUN composer install --no-interaction

# Enable rewrite in apache2 config
RUN a2enmod rewrite

# Set some volumes for logs and apache2
VOLUME /var/www/html
VOLUME /var/log/httpd
VOLUME /etc/apache2

# Expose the port
EXPOSE 8000

# Run
CMD ["symfony", "serve"]
