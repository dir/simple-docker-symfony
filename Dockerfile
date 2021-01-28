# Ubuntu 16.04 Install
FROM ubuntu:16.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
	# General Installs
	git \
	zip \
	unzip \
	wget \
	curl \
	python3-setuptools \
	nano \
	logrotate \
	# LAMP Installs
	apache2 \
	php-xdebug \
	libapache2-mod-php \
	mysql-server \
	php-mysql \
	php-apcu \
	php-gd \
	php-xml \
	php-mbstring \
	php-gettext \
	php-zip \
	php-curl \
	ca-certificates \
	openssh-client

# Composer Installation
RUN mkdir /opt/composer && \
	curl --silent --show-error -o composer-setup.php https://getcomposer.org/installer && \
	EXPECTED_SIGNATURE=$(curl --silent --show-error https://composer.github.io/installer.sig) && \
	ACTUAL_SIGNATURE=$(php -r "echo hash_file('SHA384', 'composer-setup.php');") && \
	if [ "${EXPECTED_SIGNATURE}" != "${ACTUAL_SIGNATURE}" ]; then \
		>&2 echo 'ERROR: Invalid composer installer signature' && \
		rm composer-setup.php && \
		exit 1 \
	; fi \
	&& php composer-setup.php --install-dir=/opt/composer \
	&& rm composer-setup.php \
	&& mv /opt/composer/composer.phar /usr/local/bin/composer

# Symfony Installation
RUN wget https://get.symfony.com/cli/installer -O - | bash
ENV PATH="/root/.symfony/bin:${PATH}"

# Setting path and copying local files to it
WORKDIR /usr/src/app
COPY /application .

# Install application dependencies
ENV COMPOSER_ALLOW_SUPERUSER=1
RUN composer install --no-interaction

# Enable rewrite in apache2 config
RUN a2enmod rewrite

# Expose the port
EXPOSE 8000

# Run
CMD ["symfony", "serve"]
