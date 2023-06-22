FROM php:8.2-apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apt-get update && apt-get install -y \
        git \
        gcc \
        g++ \
        make \
        autoconf \
        libc-dev \
        pkg-config \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev \
        zlib1g-dev \
        libzip-dev \
        libmagickwand-dev \
        libwebp-dev \
        libjpeg62-turbo-dev \
        libpng-dev libxpm-dev \
        libfreetype6-dev \
        build-essential \
        libomp-dev

RUN export OMP_NUM_THREADS=$(nproc)
RUN git clone https://github.com/ImageMagick/ImageMagick.git ImageMagick-7.1.1 && cd ImageMagick-7.1.1 && ./configure && make -j$(nproc) && make install && ldconfig /usr/local/lib
RUN pecl install redis
RUN docker-php-ext-enable redis