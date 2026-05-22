start:
	@systemctl start docker

stop:
	@systemctl stop docker

check:
	@systemctl status docker

up:
	@docker compose -f ./srcs/docker-compose.yaml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yaml down

re:
	@docker compose -f ./srcs/docker-compose.yaml up -d --build

clean:
	@docker stop $$(docker ps -qa);\
	docker compose down;\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
 	docker system prune -a --volumes;\

.PHONY: all re down clean