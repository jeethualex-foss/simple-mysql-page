app := simple-mysql-page
user :=
pass :=
image :=
db_user :=
db_pass :=

default: login

publish: clean setup build_mysql deploy_mysql deploy_phpmyadmin build deploy

login:
	docker login -u $(user) -p $(pass)

setup:
	export DB_USER=$(db_user)
	export DB_PASS=$(db_pass)

build:
	docker build -t $(image) .
	docker push $(image)

build_mysql:
	docker build -t $(image)-db ./mysql
	docker push $(image)-db

deploy_mysql:
	docker run --name mysql -e MYSQL_ROOT_PASSWORD=$(db_pass) -p 3306:3306 -d $(image)-db

deploy_phpmyadmin:
	docker run --name phpmyadmin --link mysql:db -p 8080:80 -d phpmyadmin

deploy:
	docker run --name $(app) --link mysql:db -e DB_USER=$(db_user) -e DB_PASS=$(db_pass) -p 80:80 -d $(image)

debug:
	docker exec -it $(app) sh

clean:
	docker stop mysql || true && docker rm mysql || true
	docker stop phpmyadmin || true && docker rm phpmyadmin || true
	docker stop $(app) || true && docker rm $(app) || true
