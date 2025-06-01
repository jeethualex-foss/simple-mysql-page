app := simple-mysql-page
user :=
pass :=
tag :=
db_pass :=

default: login

publish: build_mysql build_phpmyadmin build deploy

login:
	docker login -u $(user) -p $(pass)

build:
	docker build -t $(tag) .
	docker push $(tag)

build_mysql:
	docker build -t $(tag)-db ./mysql
	docker push $(tag)-db

build_phpmyadmin:
	docker stop mysql || true && docker rm mysql || true
	docker stop phpmyadmin || true && docker rm phpmyadmin || true
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=$(db_pass) -p 3306:3306 -d jeethualex/foss:$(app)-db
	docker run --name phpmyadmin --link mysql:db -p 8080:80 -d phpmyadmin

deploy:
	docker stop $(app) || true && docker rm $(app) || true
	docker run --name $(app) --link mysql:db -p 80:80 -d $(tag)

debug:
	docker exec -it $(app) sh

hello:
	@echo "Hello, World"

hello1:
	@echo "Hello 1, World"make