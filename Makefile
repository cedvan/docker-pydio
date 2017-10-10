build:
	@docker build -t cedvan/pydio:latest .

start:
	@docker run --name pydio -d -p 80:80 -v /tmp/pydio/data:/data/pydio -v /tmp/pydio/mysql:/var/lib/mysql -e "PYDIO_LOCALE=fr_FR" cedvan/pydio:latest

logs:
	@docker logs -f pydio

stop:
	@docker stop pydio

remove: stop
	@docker rm -f pydio

bash:
	@docker exec -it pydio bash

clean:
	@sudo rm -rf /tmp/pydio
