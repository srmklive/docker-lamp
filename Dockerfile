FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade
  
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install apache2 libxml2 libssl1.1 openssl php7.0 libapache2-mod-php7.0 php7.0-cli php7.0-curl php7.0-mbstring php7.0-curl \
  php7.0-json php7.0-mysql php7.0-pgsql php7.0-gd php7.0-bcmath php7.0-readline php7.0-zip \
  php7.0-imap php7.0-xml php7.0-json php7.0-intl php7.0-soap php7.0-memcached php-xdebug php-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e0012edf3e80b6978849f5eff0d4b4e4c79ff1609dd1e613307e16318854d24ae64f26d17af3ef0bf7cfb710ca74755a') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"  

RUN a2enmod ssl rewrite

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
