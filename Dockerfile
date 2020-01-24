FROM srmklive/docker-ubuntu:latest

LABEL maintainer="Raza Mehdi<srmk@outlook.com>"

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
  && apt-get -y upgrade
  
RUN add-apt-repository ppa:ondrej/php \
  && apt-get update

RUN apt-get -y install apache2 libxml2 libssl1.1 openssl php7.2 libapache2-mod-php7.2 php7.2-cli php7.2-curl php7.2-mbstring \
  php7.2-json php7.2-mysql php7.2-pgsql php7.2-gd php7.2-bcmath php7.2-readline \
  php7.2-zip php7.2-imap php7.2-xml php7.2-json php7.2-intl php7.2-soap \
  php7.2-memcached php-xdebug php-redis

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
  && php -r "if (hash_file('sha384', 'composer-setup.php') === 'c5b9b6d368201a9db6f74e2611495f369991b72d9c8cbd3ffbc63edff210eb73d46ffbfce88669ad33695ef77dc76976') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
  && php composer-setup.php --install-dir=/usr/bin --filename=composer \
  && php -r "unlink('composer-setup.php');"  

RUN a2enmod ssl rewrite

RUN apt-get -y autoclean \
  && apt-get -y autoremove \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80
