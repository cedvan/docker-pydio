#!/bin/bash

echo "Check environment configuration..."

# Directories
DATA_DIRECTORY=/data
WORK_DIRECTORY=/var/www
ASSETS_DIRECTORY=/assets
SCRIPTS_DIRECTORY=/scripts/pydio

# PHP Configuration
PHP_TIMEZONE=${PHP_TIMEZONE:-Europe/Paris}

# Pydio Configuration
PYDIO_HOST=${PYDIO_HOST:-localhost}
PYDIO_HTTP_PORT=${PYDIO_HTTP_PORT:-80}
PYDIO_HTTPS=${PYDIO_HTTPS:-false}
PYDIO_HTTPS_PORT=${PYDIO_HTTPS_PORT:-443}
PYDIO_HTTPS_REVERSE_PROXY=${PYDIO_HTTPS_REVERSE_PROXY:-false}
PYDIO_FORCE_HTTPS=${PYDIO_FORCE_HTTPS:-false}
PYDIO_LOCALE=${PYDIO_LOCALE:-en_US}
DB_HOST=${DB_HOST:-localhost}
DB_PORT=${DB_PORT:-3306}
DB_NAME=${DB_NAME:-pydio}
DB_USER=${DB_USER:-pydio}
DB_PASSWORD=${DB_PASSWORD:-pydio}

# Checking PHP Timezone
if [[ ! "${PHP_TIMEZONE}" =~ ^[A-Z]{1}[a-z]+/[A-Z]{1}[a-z]+$ ]]; then
    echo "ERROR: "
    echo "  Variable PHP_TIMEZONE \"${PHP_TIMEZONE}\" isn't valid ! (Format accepted : [A-Z]{1}[a-z]+/[A-Z]{1}[a-z]+)"
    exit 1
fi

# Checking Pydio HTTPS Configuration and load Pydio scheme
if [ "${PYDIO_HTTPS}" = "true" ]; then
    PYDIO_SCHEME="https"
elif [ "${PYDIO_HTTPS}" = "false" ]; then
    PYDIO_SCHEME="http"
else
    echo "ERROR: "
    echo "  Variable PYDIO_HTTPS \"${PYDIO_HTTPS}\" isn't valid ! (Values accepted : true/false)"
    exit 1
fi

# Checking HTTP PORT
if [[ ! ("${PYDIO_HTTP_PORT}" =~ ^[1-9]{1}[0-9]{0,4}$) ]] || (("${PYDIO_HTTP_PORT}" > "65535")); then
    echo "ERROR: "
    echo "  Variable PYDIO_HTTP_PORT \"${PYDIO_HTTP_PORT}\" isn't valid ! (Format accepted : integer between 1 and 65535)"
    exit 1
fi

# Checking HTTPS PORT
if [[ ! ("${PYDIO_HTTPS_PORT}" =~ ^[1-9]{1}[0-9]{0,4}$) ]] || (("${PYDIO_HTTPS_PORT}" > "65535")); then
    echo "ERROR: "
    echo "  Variable PYDIO_HTTP_PORT \"${PYDIO_HTTPS_PORT}\" isn't valid ! (Format accepted : integer between 1 and 65535)"
    exit 1
fi

# Checking Pydio HTTPS reserve proxy
if [ "${PYDIO_HTTPS_REVERSE_PROXY}" != "true" ] && [ "${PYDIO_HTTPS_REVERSE_PROXY}" != "false" ]; then
    echo "ERROR: "
    echo "  Variable PYDIO_HTTPS_REVERSE_PROXY \"${PYDIO_HTTPS_REVERSE_PROXY}\" isn't valid ! (Values accepted : true/false)"
    exit 1
fi

# Checking Pydio force HTTPS
if [ "${PYDIO_FORCE_HTTPS}" != "true" ] && [ "${PYDIO_FORCE_HTTPS}" != "false" ]; then
    echo "ERROR: "
    echo "  Variable PYDIO_FORCE_HTTPS \"${PYDIO_FORCE_HTTPS}\" isn't valid ! (Values accepted : true/false)"
    exit 1
fi

# Checking Pydio Locale
if [[ ! "${PYDIO_LOCALE}" =~ ^[a-z]{2}+_[A-Z]{2}+$ ]]; then
    echo "ERROR: "
    echo "  Variable PYDIO_LOCALE \"${PYDIO_LOCALE}\" isn't valid ! (Format accepted : [a-z]{2}+_[A-Z]{2}+)"
    exit 1
fi

# Checking database host
if [[ ! "${DB_HOST}" =~ ^[A-Za-z]+$ ]]; then
    echo "ERROR: "
    echo "  Variable DB_HOST \"${DB_HOST}\" isn't valid ! (Format accepted : [A-Za-z\_\-\.]+)"
    exit 1
fi

# Checking database port
if [[ ! ("${DB_PORT}" =~ ^[1-9]{1}[0-9]{0,4}$) ]] || (("${DB_PORT}" > "65535")); then
    echo "ERROR: "
    echo "  Variable DB_PORT \"${DB_PORT}\" isn't valid ! (Format accepted : integer between 1 and 65535)"
    exit 1
fi

# Checking database name
if [[ ! "${DB_NAME}" =~ ^[A-Za-z\_\-]+$ ]]; then
    echo "ERROR: "
    echo "  Variable DB_NAME \"${DB_NAME}\" isn't valid ! (Format accepted : [A-Za-z\_\-]+)"
    exit 1
fi

# Checking database user
if [[ ! "${DB_USER}" =~ ^[A-Za-z\_\-]+$ ]]; then
    echo "ERROR: "
    echo "  Variable DB_USER \"${DB_USER}\" isn't valid ! (Format accepted : [A-Za-z\_\-]+)"
    exit 1
fi
