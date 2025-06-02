app := simple-mysql-page
user :=
pass :=
tag :=
db_user :=
db_pass :=

default: login

publish: clean build_env build_mysql build_phpmyadmin build deploy

login:
	docker login -u $(user) -p $(pass)

build:
	docker build -t $(tag) .
	docker push $(tag)

build_env:
	export DB_USER=$(db_user)
	export DB_PASS=$(db_pass)

build_mysql:
	docker build -t $(tag)-db ./mysql
	docker push $(tag)-db

build_phpmyadmin:
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=$(db_pass) -p 3306:3306 -d $(tag)-db
	docker run --name phpmyadmin --link mysql:db -p 8080:80 -d phpmyadmin

deploy:
	docker run --name $(app) --link mysql:db -e DB_USER=$(db_user) -e DB_PASS=$(db_pass) -p 80:80 -d $(tag)

debug:
	docker exec -it $(app) sh

clean:
	docker stop mysql || true && docker rm mysql || true
	docker stop phpmyadmin || true && docker rm phpmyadmin || true
	docker stop $(app) || true && docker rm $(app) || true
