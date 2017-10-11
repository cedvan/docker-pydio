# Docker Pydio

[![Version](https://images.microbadger.com/badges/version/cedvan/pydio:8.0.1.svg)](https://microbadger.com/images/cedvan/pydio:8.0.1 "Get your own version badge on microbadger.com")
[![Docker Pulls](https://img.shields.io/docker/pulls/cedvan/pydio.svg?style=flat-square)](https://hub.docker.com/r/cedvan/pydio/)
[![Docker Stars](https://img.shields.io/docker/stars/cedvan/pydio.svg?style=flat-square)](https://hub.docker.com/r/cedvan/pydio/)
[![Docker image](https://images.microbadger.com/badges/image/cedvan/pydio.svg?style=flat-square)](https://microbadger.com/#/images/cedvan/pydio "Size docker image on Docker Hub")

[![Build Status](https://img.shields.io/travis/cedvan/docker-pydio/master.svg?style=flat-square)](https://travis-ci.org/cedvan/docker-pydio)
[![Average time to resolve an issue](http://isitmaintained.com/badge/resolution/cedvan/docker-pydio.svg)](http://isitmaintained.com/project/cedvan/docker-pydio "Average time to resolve an issue")
[![Percentage of issues still open](http://isitmaintained.com/badge/open/cedvan/docker-pydio.svg)](http://isitmaintained.com/project/cedvan/docker-pydio "Percentage of issues still open")
[![GitHub license](https://img.shields.io/:license-mit-blue.svg?style=flat-square)]()

![pydio](https://raw.githubusercontent.com/cedvan/docker-pydio/master/img/pydio.png "pydio")

Complete Solution of sharing and sync for your employees. Open source software deployed on your servers or in your cloud.

## Quick start

```bash
docker run --name pydio -d \
    -p 80:80 \
    cedvan/pydio:8.0.1
```
- Go with your browser to **localhost**
- Install pydio with wizard
- Configure database with embedded MySQL server, cf [Use MySQL embedded](#use-mysql-embedded)

## Configure specific DNS

To use a specfic DNS, configure pydio host.

```bash
docker run --name pydio -d \
    -p 80:80 \
    -e "PYDIO_HOST=domain.com" \
    cedvan/pydio:8.0.1
```

## Save Pydio data

Pydio files are saved to `/data/pydio` in container. Just mount this volume for save your configurations and files

```bash
docker run --name pydio -d \
    -v /opt/pydio:/data/pydio \
    cedvan/pydio:8.0.1
```

## Pydio database

Pydio need a database to works.

### Use MySQL embedded

By default with `DB_HOST` environment variable set to `localhost` or `127.0.0.1`, this container configure and start a embedded MySQL server.

Database default configuration :
- Name: `pydio`
- User: `pydio`
- Password: `pydio`

You can configure this parameters, cf [Pydio Options](#pydio-options)

*Sample :*

```bash
docker run --name pydio -d \
    -v /opt/pydio-mysql:/var/lib/mysql \
    cedvan/pydio:8.0.1
```
*Don't forget mount `/var/lib/mysql` to save MySQL data*

And configure database parameters in Pydio with wizard installation

![pydio](https://raw.githubusercontent.com/cedvan/docker-pydio/master/img/pydio-database-embedded.png "pydio-database-embedded")



### Use external database

*Sample with mysql*

```bash
docker run --name pydio-mysql -d \
    -v /opt/pydio-mysql:/var/lib/mysql \
    -e "MYSQL_ROOT_PASSWORD=my_pydio_db_root_password" \
    -e "MYSQL_DATABASE=my_pydio" \
    -e "MYSQL_USER=my_pydio_db_user" \
    -e "MYSQL_PASSWORD=my_pydio_db_password" \
    mysql:latest
```

```bash
docker run --name pydio -d \
    --link pydio-mysql:mysql
    -e "DB_HOST=mysql" \
    -e "DB_NAME=my_pydio" \
    -e "DB_USER=my_pydio_db_user" \
    -e "DB_PASSWORD=my_pydio_db_password" \
    cedvan/pydio:8.0.1
```

And configure database parameters in Pydio with wizard installation

## Enabled HTTPS

```bash
docker run --name pydio -d \
    -p 443:443 \
    -e "PYDIO_HTTPS=true" \
    -e "PYDIO_FORCE_HTTPS=true" \
    -v /opt/pydio/certs:/data/certs \
    cedvan/pydio:8.0.1
```
*Add your **pydio.key** and **pydio.crt** in folder **certs**. If `pydio.key` and `pydio.crt` do not exist, the container will create self-signed certificates*

## Load Pydio behind HTTPS Proxy

```bash
docker run --name pydio -d \
    -e "PYDIO_HTTPS_PORT=443" \
    -e "PYDIO_HTTPS_REVERSE_PROXY=true" \
    -v /opt/pydio/certs:/data/certs \
    cedvan/pydio:8.0.1
```
*Configure your proxy to redirect on container on port 443. No need certificates in container with this configuration*

## Pydio Options

*Please refer the docker run command options for the `--env-file` flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command. Alternately you can use fig.*

Below is the complete list of available options that can be used to customize your Pydio installation.

- **PYDIO_HOST**: The hostname of the pydio server. Defaults to `localhost`
- **PYDIO_HTTP_PORT**: The port of the pydio http server. Defaults to `80`
- **PYDIO_HTTPS**: Set to `true` to enable https support, Defaults to `false`. **If you do not use a reverse proxy, do not forget to add the certificates files**
- **PYDIO_HTTPS_PORT**: The port of the pydio https server. Defaults to `443`
- **PYDIO_HTTPS_REVERSE_PROXY**: Set to `true` if you use docker behind a reverse proxy for i.e. ssl termination. This will make pydio use the HTTPS scheme without the need to add certificates. If you do so, make sure to set your reverse proxy to target port 443. Defaults to `false`
- **PYDIO_FORCE_HTTPS**: Set to `true` if you want Pydio automatically redirect to https. Defaults to `false`
- **PYDIO_LOCALE**: Set to configure default locale used by Pydio. Defaults to `en_US`
- **PYDIO_DB_HOST**: Set to configure database host. This image provide a embedded mysql, but you can specify external database with this parameter. Defaults to `localhost`
- **PYDIO_DB_PORT**: Set to configure database port. Defaults to `3306`
- **PYDIO_DB_NAME**: Set to configure database name. Defaults to `pydio`
- **PYDIO_DB_USER**: Set to configure database user. Defaults to `pydio`
- **PYDIO_DB_PASSWORD**: Set to configure database password. Defaults to `pydio`
- **PYDIO_DB_ROOT_PASSWORD**: Set to configure database root password. Defaults to `root`
- **PHP_TIMEZONE**: Configure timezone PHP. Default `Europe/Paris`.

## Pdyio License

Pydio is open source and free to the communauty.
You can add a license to activate enterprise edition, cf [https://pydio.com/en/pricing](https://pydio.com/en/pricing)

## Contributing

See [CONTRIBUTING](CONTRIBUTING.md) file.

## References

Pydio is built by Abstrium

- https://pydio.com
- https://github.com/pydio/pydio-core
- http://www.abstrium.com
