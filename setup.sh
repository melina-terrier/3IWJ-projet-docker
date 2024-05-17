#!/bin/bash

docker compose up -d
ids=$(docker ps --format '{{.ID}}: {{.Names}}' | grep "laravel" | cut -d ':' -f 1)


for id in $ids; do
  docker exec $id composer install
  docker exec $id npm install
  docker exec $id npm run build
  docker exec $id php artisan key:generate
  docker exec $id php artisan migrate:fresh --seed
done