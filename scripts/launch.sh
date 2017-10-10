#!/bin/bash
set -e

# Load config
source /scripts/pydio/config.sh

# Initilisation
source $SCRIPTS_DIRECTORY/install/locale.sh
source $SCRIPTS_DIRECTORY/install/pydio.sh
source $SCRIPTS_DIRECTORY/install/mysql.sh
source $SCRIPTS_DIRECTORY/install/php.sh
source $SCRIPTS_DIRECTORY/install/nginx.sh

# Start services
echo "Starting Pydio..."
/usr/bin/supervisord -c /etc/supervisor/supervisord.conf
