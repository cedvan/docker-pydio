#!/bin/bash

echo "Configure Pydio..."

# Load pydio bootstrap configuration
cp -f $ASSETS_DIRECTORY/config/pydio/bootstrap_conf.php $WORK_DIRECTORY/core/src/conf/bootstrap_conf.php
sed -i "s|PYDIO_FORCE_HTTPS|$PYDIO_FORCE_HTTPS|g" $WORK_DIRECTORY/core/src/conf/bootstrap_conf.php
sed -i "s|PYDIO_LOCALE|$PYDIO_LOCALE|g" $WORK_DIRECTORY/core/src/conf/bootstrap_conf.php

# Load predefined diag result
cp -f $ASSETS_DIRECTORY/config/pydio/diag_result.php $WORK_DIRECTORY/core/src/plugins/boot.conf/diag_result.php

# Load pydio bootstrap
cp -f $ASSETS_DIRECTORY/config/pydio/bootstrap.json $WORK_DIRECTORY/core/src/plugins/boot.conf/bootstrap.json
sed -i "s|DB_HOST|$DB_HOST|g" $WORK_DIRECTORY/core/src/plugins/boot.conf/bootstrap.json
sed -i "s|DB_NAME|$DB_NAME|g" $WORK_DIRECTORY/core/src/plugins/boot.conf/bootstrap.json
sed -i "s|DB_USER|$DB_USER|g" $WORK_DIRECTORY/core/src/plugins/boot.conf/bootstrap.json
sed -i "s|DB_PASSWORD|$DB_PASSWORD|g" $WORK_DIRECTORY/core/src/plugins/boot.conf/bootstrap.json

# Load predefined encoding
cp -f $ASSETS_DIRECTORY/config/pydio/encoding.php $WORK_DIRECTORY/core/src/plugins/boot.conf/encoding.php
sed -i "s|PYDIO_LOCALE|$PYDIO_LOCALE|g" $WORK_DIRECTORY/core/src/plugins/boot.conf/encoding.php

# Create data directory
if [ ! -f $DATA_DIRECTORY/pydio/plugins/boot.conf/first_run_passed ]; then
    echo "Initialize pydio data"
    rm -rf $DATA_DIRECTORY/pydio/*
    cp -rf $WORK_DIRECTORY/core/src/data/* $DATA_DIRECTORY/pydio/

    # Load first boot configuration
    mkdir -p $DATA_DIRECTORY/pydio/plugins/boot.conf
    cp -f $WORK_DIRECTORY/core/src/plugins/boot.conf/diag_result.php $DATA_DIRECTORY/pydio/plugins/boot.conf/diag_result.php
    cp -f $WORK_DIRECTORY/core/src/plugins/boot.conf/encoding.php $DATA_DIRECTORY/pydio/plugins/boot.conf/encoding.php
fi

echo "Configure path pydio data"
rm -rf $WORK_DIRECTORY/core/src/data
ln -s $DATA_DIRECTORY/pydio $WORK_DIRECTORY/core/src/data

# Loading permissions
echo "Loading permissions..."
chown -R www-data:www-data \
    $WORK_DIRECTORY/core/src/data \
    $DATA_DIRECTORY/pydio
