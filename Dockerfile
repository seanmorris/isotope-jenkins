FROM jenkins/jenkins:2.60.3

MAINTAINER Sean Morris <sean@seanmorr.is>

USER root

RUN mkdir /app

COPY ./composer.json /app

RUN apt-get update \
	&& apt-get install -y --no-install-recommends git zip php \
	&& curl -sS https://getcomposer.org/installer \
		| php -- --install-dir=/usr/bin/ --filename=composer \
	&& cd /app \
	&& composer install --prefer-source --no-interaction \
	&& ln -s /app/vendor/seanmorris/ids/source/Idilic/idilic /usr/local/bin/idilic \
	&& idilic help

USER jenkins