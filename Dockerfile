FROM php:7.0-fpm-alpine

# php extentions
RUN apk add --no-cache\
		freetype-dev \
		freetype \
		libjpeg-turbo-dev \
		libjpeg-turbo \
		libmcrypt-dev \
		libmcrypt \
		libpng-dev \
		libpng \
		libpq \
		postgresql-dev \
		sqlite-libs \
		sqlite-dev \
		curl-dev \
		icu-dev \
		icu \
	&& docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
	&& docker-php-ext-install iconv mcrypt zip pdo pdo_pgsql pdo_sqlite pdo_mysql intl curl mbstring gd \
	&& apk del \
		freetype-dev \
		libjpeg-turbo-dev \
		libmcrypt-dev \
		libpng-dev \
		postgresql-dev \
		sqlite-dev \
		curl-dev \
		icu-dev

RUN docker-php-source extract \
	&& apk add --no-cache --virtual .phpize-deps $PHPIZE_DEPS \
	&& pecl install apcu \
	&& apk del .phpize-deps \
	&& docker-php-ext-enable apcu \
	&& docker-php-source delete \
