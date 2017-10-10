#!/bin/bash

echo "Configure Nginx..."

# Vhosts
echo "Loading Nginx vhosts..."
rm -f /etc/nginx/sites-enabled/*
if [ "${PYDIO_HTTPS}" == "true" ]; then

    if [ "${PYDIO_HTTPS_REVERSE_PROXY}" == "false" ]; then

        echo "Loading HTTPS Certificates..."

        if [ ! -e "${DATA_DIRECTORY}/certs/pydio.key" ] && [ ! -e "${DATA_DIRECTORY}/certs/pydio.crt" ]; then

            echo "Generating self-signed HTTPS Certificates..."

            mkdir -p ${DATA_DIRECTORY}/certs

            openssl req \
                -x509 \
                -nodes \
                -days 365 \
                -newkey rsa:2048 \
                -keyout "${DATA_DIRECTORY}/certs/pydio.key" \
                -out "${DATA_DIRECTORY}/certs/pydio.crt" \
                -subj "/C=SS/ST=SS/L=SelfSignedCity/O=SelfSignedOrg/CN=${PYDIO_HOST}"

        elif [ -e "${DATA_DIRECTORY}/certs/pydio.key" ] && [ -e "${DATA_DIRECTORY}/certs/pydio.crt" ]; then

            echo "Using provided HTTPS Certificates..."

        else

            if [ -e "${DATA_DIRECTORY}/certs/pydio.key" ]; then
                echo "ERROR: "
                echo "  File pydio.key exists in folder certs/ but no pydio.crt"
                exit 1
            else
                echo "ERROR: "
                echo "  File pydio.crt exists in folder certs/ but no pydio.key"
                exit 1
            fi

        fi

        # Add certificates trusted
        ln -s $DATA_DIRECTORY/certs /usr/local/share/ca-certificates/pydio
        update-ca-certificates

        sed -i "s|PYDIO_HOST|$PYDIO_HOST|g" /etc/nginx/sites-available/pydio-https.conf
        sed -i "s|PYDIO_HTTP_PORT|$PYDIO_HTTP_PORT|g" /etc/nginx/sites-available/pydio-https.conf
        sed -i "s|PYDIO_HTTPS_PORT|$PYDIO_HTTPS_PORT|g" /etc/nginx/sites-available/pydio-https.conf
        ln -s /etc/nginx/sites-available/pydio-https.conf /etc/nginx/sites-enabled/pydio-https.conf

    else
        sed -i "s|PYDIO_HOST|$PYDIO_HOST|g" /etc/nginx/sites-available/pydio-https-reverse.conf
        sed -i "s|PYDIO_HTTP_PORT|$PYDIO_HTTP_PORT|g" /etc/nginx/sites-available/pydio-https-reverse.conf
        sed -i "s|PYDIO_HTTPS_PORT|$PYDIO_HTTPS_PORT|g" /etc/nginx/sites-available/pydio-https-reverse.conf
        ln -s /etc/nginx/sites-available/pydio-https-reverse.conf /etc/nginx/sites-enabled/pydio-https-reverse.conf
    fi
else
    sed -i "s|PYDIO_HOST|$PYDIO_HOST|g" /etc/nginx/sites-available/pydio-http.conf
    sed -i "s|PYDIO_HTTP_PORT|$PYDIO_HTTP_PORT|g" /etc/nginx/sites-available/pydio-http.conf
    ln -s /etc/nginx/sites-available/pydio-http.conf /etc/nginx/sites-enabled/pydio-http.conf
fi

# Logs
mkdir -p $DATA_DIRECTORY/nginx

# Load permissions
echo "Loading Nginx permissions..."
chown -R www-data:www-data \
    $DATA_DIRECTORY/nginx
