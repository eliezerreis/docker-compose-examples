#!/bin/bash

set -e

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'DRUPAL_PASSWORD'

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE ROLE $DRUPAL_USER WITH LOGIN NOINHERIT ENCRYPTED PASSWORD '$DRUPAL_PASSWORD';
    CREATE DATABASE $DRUPAL_DB;
    GRANT ALL PRIVILEGES ON DATABASE $DRUPAL_DB TO $DRUPAL_USER;
    ALTER DATABASE $DRUPAL_DB SET bytea_output = 'escape';
EOSQL