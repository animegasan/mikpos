# Startup from alpine
FROM alpine:3.14
LABEL Maintainer = "Hilman Maulana, Naufal Azkia"
LABEL Description = "Mikpos is a web-based application (MikroTik API PHP class) management users and payments that can be used in HotSpot and PPPoE MikroTik RouterOS users."

# Setup document root
WORKDIR /var/www/html

# Expose the port
EXPOSE 8080
EXPOSE 3306

# Install packages
RUN apk add --no-cache \
    nginx \
    php7 \
    php7-fpm \
    php7-intl \
    php7-sockets \
    php7-dom \
    php7-xml \
    php7-xmlwriter \
    php7-simplexml \
    php7-tokenizer \
    php7-mysqli \
    php7-session \
    php7-openssl \
    php7-json \
    php7-curl \
    php7-mbstring \
    mysql \
    mysql-client \
    supervisor

# Configure nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Configure PHP-FPM
COPY conf/fpm-pool.conf /etc/php7/php-fpm.d/www.conf
COPY conf/php.ini /etc/php7/conf.d/custom.ini

# Configure mysql
COPY conf/my.cnf /etc/mysql/my.cnf
RUN mkdir -p /app/mysql && \
    mkdir -p /run/mysqld && \
    mysql_install_db --user=root > /dev/null

# Configure supervisord
COPY conf/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add application
COPY --chown=nginx src/ /var/www/html/

# Start mysql, Create database and Install Mikpos
RUN /bin/sh -c "/usr/bin/mysqld --user=root &" && \
    while ! mysqladmin ping --silent; do sleep 1; echo "wait 1 second"; done && \
    mysql -u root -e "CREATE DATABASE IF NOT EXISTS \`mikpos\` CHARACTER SET utf8 COLLATE utf8_general_ci;" && \
    mysql -u root -e "FLUSH PRIVILEGES;" && \
    apk add --no-cache composer && \
    composer install && \
    php spark migrate && \
    php spark db:seed UsersSeeder && \
    apk del composer

# Let supervisord start nginx & php-fpm
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
