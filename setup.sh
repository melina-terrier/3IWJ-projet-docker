#!/bin/bash

docker compose up -d
ids=$(docker ps --format '{{.ID}}: {{.Names}}' | grep "laravel" | cut -d ':' -f 1)


for id in $ids; do
  docker exec $id composer update
  echo "Commande 'composer update' executée"

  docker exec $id composer install
  echo "Commande 'composer install' executée"

  docker exec $id npm install
  echo "Commande 'npm install' executée"

  docker exec $id npm run build
  echo "Commande 'npm run build' executée"

  docker exec $id php artisan key:generate
  echo "Commande 'php artisan key:generate' executée"

  docker exec $id php artisan migrate:fresh --seed
  echo "Commande 'php artisan migrate:fresh --seed' executée"

done