FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade
  
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get update && apt-get -y upgrade && apt-get -y install apache2 php8.0 libapache2-mod-php8.0 php8.0-common \
  php8.0-cli php8.0-curl php8.0-mbstring \
  php8.0-mysql php8.0-pgsql php8.0-gd php8.0-bcmath php8.0-readline \
  php8.0-zip php8.0-imap php8.0-xml php8.0-intl php8.0-soap \
  php8.0-memcached php8.0-xdebug php8.0-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"  

RUN a2enmod ssl rewrite

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
