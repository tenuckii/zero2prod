#!/usr/bin/env bash
set -x
set -eo pipefail

if ![-x "$(command -v psql)"]; then
    echo >&2 "Error: psql is not installed."
    exit 1
fi

if ![-x "$(command -v sqlx)"]; then
    echo >&2 "Error: sqlx is not installed."
    echo >&2 "Use"
    echo >&2 "cargo instal sqlx-cli --no-default-features --features rustls,postgres"
    echo >&2 "to install it."
    exit 1
fi



DB_USER=${POSTGRES_USER:=postgres}
DB_PASSWORD="${POSTGRES_PASSWORD:=password}"
DB_NAME="${POSTGRES_DB:=newsletter}"
DB_PORT="${POSTGRES_PORT:=5432}"
DB_HOST="${POSTGRES_HOST:=localhost}"

docker run \
    -e POSTGRES_USER=${DB_USER} \
    -e POSTGRES_PASSWORD=${DB_PASSWORD} \
    -e POSTGRES_DB=${DB_NAME} \
    -p "${DB_PORT}:5432" \
    -d postgres \
    postgres -N 1000

export PGPASSWORD="${DB_PASSWORD}"
until psql -h "${DB_HOST}" -U "${DB_USER}" -p "${DB_PORT}" -d "postgres" -c '\q'; do
    >&2 echo "Postgres is still unavailable - sleeping"
    sleep 1
done

>&2 echo "Postgres is up and running on post ${DB_PORT}"

DATABASE_URL=postgres://${DB_USER}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_NAME}
export DATABASE_URL
sql database create
