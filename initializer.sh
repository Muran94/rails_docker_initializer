#!/bin/bash
# 1. Rails new
printf '\033[36m%s\033[m\n' 'docker-compose run web rails new . --force --no-deps --database=postgreql'
docker-compose run web rails new . --force --no-deps --database=postgresql --skip-bundle
wait



# 2. docker-compose build
printf '\033[36m%s\033[m\n' 'docker-compose build'
docker-compose build
wait



# 3. Install Webpacker
printf '\033[36m%s\033[m\n' 'docker-compose run web rails webpacker:install'
docker-compose run web rails webpacker:install
wait



# 4. Configure database
printf '\033[36m%s\033[m\n' 'Copying database.yml.'
cp -f database.yml config/database.yml && rm database.yml
wait



# 5. Create database
printf '\033[36m%s\033[m\n' 'Creating database.'
docker-compose run web rails db:create
wait



# 6. docker-compose up
printf '\033[36m%s\033[m\n' 'Creating database.'
docker-compose up
wait