app := simple-mysql-page
user :=
pass :=
tag :=

default: login

publish: phpmyadmin build deploy

login:
	docker login -u $(user) -p $(pass)

build:
	docker build -t $(tag) .
	docker push $(tag)

deploy:
	docker stop $(app) || true && docker rm $(app) || true
	docker run --privileged --name $(app) -d -p 80:80 $(tag)

debug:
	docker exec -it $(app) sh

phpmyadmin:
	docker stop mysql || true && docker rm mysql || true
	docker stop phpmyadmin || true && docker rm phpmyadmin || true
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=secret -p 3306:3306 -d mysql
	docker run --name phpmyadmin --link mysql:db -p 8080:80 -d phpmyadmin

hello:
	@echo "Hello, World"

hello1:
	@echo "Hello 1, World"