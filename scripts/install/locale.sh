#!/bin/bash

echo "Configure locale..."

update-locale LANG=$PYDIO_LOCALE.UTF-8

echo "LC_ALL=$PYDIO_LOCALE.UTF-8" >> /root/.bashrc
echo "LANG=$PYDIO_LOCALE.UTF-8" >> /root/.bashrc
echo "LANGUAGE=$PYDIO_LOCALE.UTF-8" >> /root/.bashrc

export LC_ALL=$PYDIO_LOCALE.UTF-8
export LANG=$PYDIO_LOCALE.UTF-8
export LANGUAGE=$PYDIO_LOCALE.UTF-8
