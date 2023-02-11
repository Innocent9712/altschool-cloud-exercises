article - https://www.digitalocean.com/community/tutorials/how-to-install-and-set-up-laravel-with-docker-compose-on-ubuntu-22-04

prereq

install docker - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04
install docker compose - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-compose-on-ubuntu-22-04


clone the repo into app
cd into app

create a Dockerfile to build app image with content
```Dockerfile
FROM php:8.2.2-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

USER $user
```

copy .env.example to .env and make the following changes:

```
DB_CONNECTION=mysql
DB_HOST=db
DB_PORT=3306
DB_DATABASE=laravel
DB_USERNAME=innocent
DB_PASSWORD=innocent
```


create and nginx config file named `app.conf` in ./docker-compose/nginx
with content

server {
    listen 80;
    index index.php index.html;
    error_log  /var/log/nginx/error.log;
    access_log /var/log/nginx/access.log;
    root /var/www/public;
    location ~ \.php$ {
        try_files $uri =404;
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass app:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
    location / {
        try_files $uri $uri/ /index.php?$query_string;
        gzip_static on;
    }
}


create a docker-compose.yml file with content

```yaml
version: "3.7"
services:
  app:
    build:
      args:
        user: innocent
        uid: 1000
      context: ./
      dockerfile: Dockerfile
    image: my-app
    container_name: app
    restart: unless-stopped
    working_dir: /var/www/
    volumes:
      - ./:/var/www
    networks:
      - frontend
      - backend

  db:
    image: mysql:8.0
    container_name: db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
      SERVICE_TAGS: dev
      SERVICE_NAME: mysql
    volumes:
      - mysql-data:/var/lib/mysql
    networks:
      - backend

  nginx:
    image: nginx:alpine
    container_name: nginx-server
    restart: unless-stopped
    ports:
      - 80:80
    volumes:
      - ./:/var/www
      - ./docker-compose/nginx:/etc/nginx/conf.d/
    networks:
      - frontend

networks:
  frontend:
    driver: bridge
  backend:
volumes:
  mysql-data:
    driver: local
```

to run the app, first build the app image

`docker compose build app`

then run the compose file with

`docker compose up -d`

this will spin up all container instances

run
`docker compose exec app rm -rf vendor composer.lock`
to remove old composer lock file

then run
`docker compose exec app composer install`
to install composer deps

run
`docker compose exec app php artisan key:generate`
to generate app key

then run
`docker compose exec app php artisan migrate --seed`
to perform possible migration or seeding

check the ip address on port 80 and it should be fine

Now all that's left is to handle the volume and network extra stuff


Uses this updated Dockerfile instead

```Dockerfile
FROM php:8.2.2-fpm

# Arguments defined in docker-compose.yml
ARG user
ARG uid

# Install system dependencies
RUN apt-get update && apt-get install -y \
    git \
    curl \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Get latest Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Create system user to run Composer and Artisan Commands
RUN useradd -G www-data,root -u $uid -d /home/$user $user
RUN mkdir -p /home/$user/.composer && \
    chown -R $user:$user /home/$user

# Set working directory
WORKDIR /var/www

# Add files, set permission and install deps
ADD . /var/www
RUN chown -R $user:www-data .
USER $user
RUN rm -rf vendor composer.lock && composer install &&\
        php artisan key:generate

#CMD ["php", "artisan", "migrate", "--seed"]
#CMD ["php", "artisan", "migrate"]
```

And this updated docker-compoes.yml

```yml
version: "3.7"
services:
  db:
    image: mysql:8.0
    container_name: db
    restart: unless-stopped
    environment:
      MYSQL_DATABASE: ${DB_DATABASE}
      MYSQL_ROOT_PASSWORD: ${DB_PASSWORD}
      MYSQL_PASSWORD: ${DB_PASSWORD}
      MYSQL_USER: ${DB_USERNAME}
      SERVICE_TAGS: dev
      SERVICE_NAME: mysql
    volumes:
      - mysql-data:/var/lib/mysql
    networks:
      - backend

  app:
    build:
      args:
        user: innocent
        uid: 1000
      context: ./
      dockerfile: Dockerfile
    image: my-app
    container_name: app
    #restart: unless-stopped
    working_dir: /var/www/
    networks:
      - frontend
      - backend
    depends_on:
      - db

  nginx:
    image: nginx:alpine
    container_name: nginx-server
    restart: unless-stopped
    ports:
      - 80:80
    volumes:
      - ./:/var/www
      - ./docker-compose/nginx:/etc/nginx/conf.d/
    networks:
      - frontend

networks:
  frontend:
    driver: bridge
  backend:
volumes:
  mysql-data:
    driver: local
```