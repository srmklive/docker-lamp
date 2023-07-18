FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade
  
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get update && apt-get -y upgrade && apt-get -y install apache2 php8.2 libapache2-mod-php8.2 php8.2-common \
  php8.2-cli php8.2-curl php8.2-mbstring \
  php8.2-mysql php8.2-pgsql php8.2-gd php8.2-bcmath php8.2-readline \
  php8.2-zip php8.2-imap php8.2-xml php8.2-intl php8.2-soap \
  php8.2-memcached php8.2-xdebug php8.2-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'e21205b207c3ff031906575712edab6f13eb0b361f2085f1f1237b7126d785e826a450292b6cfd1d64d92e6563bbde02') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"  

RUN a2enmod ssl rewrite

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
